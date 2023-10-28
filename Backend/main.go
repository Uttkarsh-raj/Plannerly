package main

import (
	"log"
	"os"

	"github.com/Uttkarsh-raj/To_Do_App/routes"
	"github.com/gin-gonic/gin"
)

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8000"
	}
	router := gin.New()
	router.Use(gin.Logger())  //logs
	routes.UserRoutes(router) //user auth routes
	routes.TaskRoutes(router) //tasks routes
	log.Fatal(router.Run(":" + port))
}
