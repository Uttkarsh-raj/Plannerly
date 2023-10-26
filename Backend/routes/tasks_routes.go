package routes

import (
	"github.com/Uttkarsh-raj/To_Do_App/controllers"
	"github.com/Uttkarsh-raj/To_Do_App/middleware"
	"github.com/gin-gonic/gin"
)

func TaskRoutes(incomingRoutes *gin.Engine) {
	incomingRoutes.Use(middleware.Authentication())
	incomingRoutes.POST("/addTask", controllers.AddNewTask())
}
