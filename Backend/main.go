package main

import (
	"fmt"
	"log"
	"os"

	"github.com/Uttkarsh-raj/To_Do_App/middleware"
	"github.com/Uttkarsh-raj/To_Do_App/routes"
	"github.com/gin-gonic/gin"
)

func main() {
	fmt.Println("Hello gophers")
	port := os.Getenv("PORT")
	if port == "" {
		port = "8000"
	}
	router := gin.New()
	router.Use(gin.Logger())
	routes.UserRoutes(router)
	routes.TaskRoutes(router)
	log.Print(os.Getenv("SECRET_KEY"))

	router.Use(middleware.Authentication())

	router.GET("/api-1", func(ctx *gin.Context) {
		ctx.JSON(200, gin.H{"success": "Access granted for api-1"})
	})

	router.GET("/api-2", func(ctx *gin.Context) {
		ctx.JSON(200, gin.H{"success": "Access granted for api-2"})
	})

	log.Fatal(router.Run(":" + port))
}
