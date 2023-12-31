package controllers

import (
	"context"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/Uttkarsh-raj/To_Do_App/database"
	"github.com/Uttkarsh-raj/To_Do_App/models"
	"github.com/dgrijalva/jwt-go"
	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

var taskCollection *mongo.Collection = database.OpenCollection(database.Client, "tasks")
var SECRET_KEY = os.Getenv("SECRET_KEY")

func AddNewTask() gin.HandlerFunc {
	return func(c *gin.Context) {
		ctx, cancel := context.WithTimeout(context.Background(), 100*time.Second)
		var task models.Task
		defer cancel()
		if err := c.BindJSON(&task); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error(), "success": false})
			return
		}
		log.Print(task)
		task.ID = primitive.NewObjectID()
		validationError := validate.Struct(task)
		if validationError != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": validationError.Error(), "success": false})
		}
		resultInsertionNumber, insertErr := taskCollection.InsertOne(ctx, task)
		if insertErr != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"success": false, "error": "Task creation Failed!!"})
			return
		}
		log.Print(resultInsertionNumber)
		defer cancel()
		response := gin.H{
			"success": true,
			"message": "Task created successfully",
			"data":    task, // Include the task data in the response.
		}
		c.JSON(http.StatusOK, response)
	}
}

func UpdateTask() gin.HandlerFunc {
	return func(c *gin.Context) {
		taskId := c.Param("id")
		var updateFields map[string]interface{}

		if err := c.BindJSON(&updateFields); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"success": false, "error": err.Error()})
			return
		}

		ctx, cancel := context.WithTimeout(context.Background(), 100*time.Second)
		defer cancel()

		objID, err := primitive.ObjectIDFromHex(taskId)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"success": false, "error": "Invalid ID format"})
			return
		}

		update := bson.M{
			"$set": updateFields,
		}

		// Check if the task exists before attempting to update it
		var existingTask models.Task
		err = taskCollection.FindOne(ctx, bson.M{"_id": objID}).Decode(&existingTask)
		if err != nil {
			c.JSON(http.StatusNotFound, gin.H{"success": false, "error": "Task not found"})
			return
		}

		result, err := taskCollection.UpdateOne(ctx, bson.M{"_id": objID}, update)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"success": false, "error": err.Error()})
			return
		}
		err = taskCollection.FindOne(ctx, bson.M{"_id": objID}).Decode(&existingTask)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"success": false, "error": err.Error()})
			return
		}

		if result.ModifiedCount == 0 {
			c.JSON(http.StatusOK, gin.H{"success": true, "data": existingTask})
			return
		}

		c.JSON(http.StatusOK, gin.H{"success": true, "data": existingTask})
	}
}

func GetTaskById() gin.HandlerFunc {
	return func(c *gin.Context) {
		ctx, cancel := context.WithTimeout(context.Background(), 100*time.Second)
		var task models.Task

		idParam := c.Param("id")
		objID, err := primitive.ObjectIDFromHex(idParam)
		defer cancel()
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"success": false, "error": "Invalid ID format"})
			return
		}
		err = taskCollection.FindOne(ctx, bson.M{"_id": objID}).Decode(&task)
		defer cancel()
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"success": false, "error": err.Error()})
			return
		}
		response := gin.H{
			"success": true,
			"data":    task,
		}
		c.JSON(http.StatusOK, response)
	}
}

func GetUrgentTasks() gin.HandlerFunc {
	return func(c *gin.Context) {
		tokenString := c.GetHeader("token")
		if tokenString == "" {
			c.JSON(http.StatusBadRequest, gin.H{"success": false, "error": "No token Provided."})
			return
		}
		token, err := jwt.Parse(tokenString, func(t *jwt.Token) (interface{}, error) { return []byte(SECRET_KEY), nil })
		if err != nil {
			c.JSON(http.StatusUnauthorized, gin.H{"success": false, "error": "Invalid Token"})
			return
		}
		if claims, ok := token.Claims.(jwt.MapClaims); ok && token.Valid {
			user_id := claims["Uid"].(string)
			ctx, cancel := context.WithTimeout(context.Background(), 100*time.Second)
			var tasks []models.Task
			var completed, total int

			cursor, err := taskCollection.Find(ctx, bson.M{"user_id": user_id, "urgent": true})
			defer cancel()
			if err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"success": false, "error": err.Error()})
				return
			}
			defer cursor.Close(ctx)
			for cursor.Next(ctx) {
				var task models.Task
				if err := cursor.Decode(&task); err != nil {
					c.JSON(http.StatusInternalServerError, gin.H{"success": false, "error": err.Error()})
					return
				}
				if task.Completed == true {
					completed++
				}
				total++
				tasks = append(tasks, task)
			}
			if err := cursor.Err(); err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"success": false, "error": err.Error()})
				return
			}
			if len(tasks) == 0 {
				tasks = []models.Task{}
			}
			response := gin.H{
				"success":   true,
				"data":      tasks,
				"completed": completed,
				"total":     total,
			}

			c.JSON(http.StatusOK, response)
		} else {
			c.JSON(http.StatusUnauthorized, gin.H{"sucess": false, "error": "Invalid token"})

		}
	}
}

func GetRegularTasks() gin.HandlerFunc {
	return func(c *gin.Context) {
		tokenString := c.GetHeader("token")
		if tokenString == "" {
			c.JSON(http.StatusBadRequest, gin.H{"success": false, "error": "No token Provided."})
			return
		}
		token, err := jwt.Parse(tokenString, func(t *jwt.Token) (interface{}, error) { return []byte(SECRET_KEY), nil })
		if err != nil {
			c.JSON(http.StatusUnauthorized, gin.H{"success": false, "error": "Invalid Token"})
			return
		}
		if claims, ok := token.Claims.(jwt.MapClaims); token.Valid && ok {
			user_id := claims["Uid"].(string)
			ctx, cancel := context.WithTimeout(context.Background(), 100*time.Second)
			var tasks []models.Task
			var completed, total int
			cursor, err := taskCollection.Find(ctx, bson.M{"user_id": user_id, "urgent": false})
			defer cancel()
			if err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"success": false, "error": err.Error()})
				return
			}
			defer cursor.Close(ctx)
			for cursor.Next(ctx) {
				var task models.Task
				if err := cursor.Decode(&task); err != nil {
					c.JSON(http.StatusInternalServerError, gin.H{"success": false, "error": err.Error()})
					return
				}
				println(task.Completed)
				if task.Completed == true {
					completed++
				}
				total++
				tasks = append(tasks, task)
			}

			if err := cursor.Err(); err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"success": false, "error": err.Error()})
				return
			}
			if len(tasks) == 0 {
				tasks = []models.Task{}
			}

			response := gin.H{
				"success":   true,
				"data":      tasks,
				"completed": completed,
				"total":     total,
			}

			c.JSON(http.StatusOK, response)

		} else {
			c.JSON(http.StatusUnauthorized, gin.H{"sucess": false, "error": "Invalid token"})
		}
	}
}

func GetAllTask() gin.HandlerFunc {
	return func(c *gin.Context) {
		tokenString := c.GetHeader("token")
		if tokenString == "" {
			c.JSON(http.StatusUnauthorized, gin.H{"success": false, "error": "No token Provided"})
			return
		}
		log.Print(tokenString)
		token, err := jwt.Parse(tokenString, func(t *jwt.Token) (interface{}, error) { return []byte(SECRET_KEY), nil })
		if err != nil {
			c.JSON(http.StatusUnauthorized, gin.H{"success": false, "error": "Invalid Token"})
			return
		}
		log.Print(token)
		if claims, ok := token.Claims.(jwt.MapClaims); ok && token.Valid {
			log.Print("claims\n")
			log.Print(claims)
			user_id := claims["Uid"].(string)
			// Now you have the user_id from the token
			log.Print(user_id)
			ctx, cancel := context.WithTimeout(context.Background(), 100*time.Second)
			var tasks []models.Task

			cursor, err := taskCollection.Find(ctx, bson.M{"user_id": user_id})
			defer cancel()
			if err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"success": false, "error": err.Error()})
				return
			}
			defer cursor.Close(ctx)

			for cursor.Next(ctx) {
				var task models.Task
				if err := cursor.Decode(&task); err != nil {
					c.JSON(http.StatusInternalServerError, gin.H{"success": false, "error": err.Error()})
					return
				}
				tasks = append(tasks, task)
			}

			if err := cursor.Err(); err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"success": false, "error": err.Error()})
				return
			}

			if len(tasks) == 0 {
				tasks = []models.Task{}
			}

			response := gin.H{
				"success": true,
				"data":    tasks,
			}

			c.JSON(http.StatusOK, response)
		} else {
			c.JSON(http.StatusUnauthorized, gin.H{"sucess": false, "error": "Invalid token"})
		}

	}
}

func DeleteTask() gin.HandlerFunc {
	return func(c *gin.Context) {
		idString := c.Param("id")
		id, err := primitive.ObjectIDFromHex(idString)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"success": false, "error": err.Error()})
			return
		}
		var task models.Task
		ctx, cancel := context.WithTimeout(context.Background(), 100*time.Second)
		err = taskCollection.FindOne(ctx, bson.M{"_id": id}).Decode(&task)
		defer cancel()
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"success": false, "error": err.Error()})
			return
		}
		_, err = taskCollection.DeleteOne(ctx, bson.M{"_id": id})
		defer cancel()
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"success": false, "error": err.Error()})
			return
		}

		c.JSON(http.StatusOK, gin.H{"success": true, "data": task})
	}
}

func SearchTask() gin.HandlerFunc {
	return func(c *gin.Context) {
		tokenString := c.GetHeader("token")
		if tokenString == "" {
			c.JSON(http.StatusUnauthorized, gin.H{"success": false, "error": "No token Provided"})
			return
		}
		token, err := jwt.Parse(tokenString, func(t *jwt.Token) (interface{}, error) { return []byte(SECRET_KEY), nil })
		if err != nil {
			c.JSON(http.StatusUnauthorized, gin.H{"success": false, "error": "Invalid Token"})
			return
		}
		if claims, ok := token.Claims.(jwt.MapClaims); ok && token.Valid {
			user_id := claims["Uid"].(string)
			var reqBody map[string]interface{}
			if err := c.ShouldBindJSON(&reqBody); err != nil {
				c.JSON(http.StatusBadRequest, gin.H{"error": err.Error(), "success": false})
				return
			}
			searchString, ok := reqBody["search"].(string)
			if !ok {
				c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid or missing 'search' in the request body", "success": false})
				return
			}
			query := bson.M{
				"user_id": user_id,
				"$or": []bson.M{
					{"title": bson.M{"$regex": primitive.Regex{Pattern: searchString, Options: "i"}}},
					{"description": bson.M{"$regex": primitive.Regex{Pattern: searchString, Options: "i"}}},
					// bson.M{"title": bson.M{"$regex": primitive.Regex{Pattern: searchString, Options: "i"}}},
					// bson.M{"description": bson.M{"$regex": primitive.Regex{Pattern: searchString, Options: "i"}}},
				},
			}
			ctx, cancel := context.WithTimeout(context.Background(), 100*time.Second)
			var urgentTasks []models.Task
			var regularTasks []models.Task

			cursor, err := taskCollection.Find(ctx, query)
			defer cancel()
			if err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error(), "success": false})
				return
			}

			for cursor.Next(ctx) {
				var task models.Task
				if err := cursor.Decode(&task); err != nil {
					c.JSON(http.StatusInternalServerError, gin.H{"success": false, "error": err.Error()})
					return
				}
				if task.Urgent == true {
					urgentTasks = append(urgentTasks, task)
				} else {
					regularTasks = append(regularTasks, task)
				}
			}
			if err := cursor.Err(); err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"success": false, "error": err.Error()})
				return
			}
			if len(regularTasks) == 0 {
				regularTasks = []models.Task{}
			}
			if len(urgentTasks) == 0 {
				urgentTasks = []models.Task{}
			}
			response := gin.H{
				"success": true,
				"data": gin.H{
					"regularTasks": regularTasks,
					"urgentTasks":  urgentTasks,
				},
			}

			c.JSON(http.StatusOK, response)
		} else {
			c.JSON(http.StatusUnauthorized, gin.H{"sucess": false, "error": "Invalid token"})
		}
	}
}
