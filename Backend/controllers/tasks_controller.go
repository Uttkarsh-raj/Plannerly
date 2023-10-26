package controllers

import (
	"context"
	"log"
	"net/http"
	"time"

	"github.com/Uttkarsh-raj/To_Do_App/database"
	"github.com/Uttkarsh-raj/To_Do_App/models"
	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

var taskCollection *mongo.Collection = database.OpenCollection(database.Client, "tasks")

func AddNewTask() gin.HandlerFunc {
	return func(c *gin.Context) {
		ctx, cancel := context.WithTimeout(context.Background(), 100*time.Second)
		var task models.Task

		if err := c.BindJSON(&task); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		defer cancel()
		log.Print(task)
		task.ID = primitive.NewObjectID()
		validationError := validate.Struct(task)
		if validationError != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": validationError.Error()})
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
