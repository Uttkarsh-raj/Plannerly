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

//to run the docker file use the following line of code
// docker run -p 8081:8080 -it plannerly-backend
// map the 8080 port of the docker file to 8081 in local (since it was not free) and then run "-it dockerFileName"
