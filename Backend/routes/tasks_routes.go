package routes

import (
	"github.com/Uttkarsh-raj/To_Do_App/controllers"
	"github.com/Uttkarsh-raj/To_Do_App/middleware"
	"github.com/gin-gonic/gin"
)

func TaskRoutes(incomingRoutes *gin.Engine) {
	incomingRoutes.Use(middleware.Authentication())
	incomingRoutes.POST("/addTask", controllers.AddNewTask())
	incomingRoutes.PATCH("/update/:id", controllers.UpdateTask())
	incomingRoutes.GET("/getTasks", controllers.GetAllTask())
	incomingRoutes.GET("/getTask/:id", controllers.GetTaskById())
	incomingRoutes.GET("/tasks/urgent", controllers.GetUrgentTasks())
	incomingRoutes.GET("/tasks/regular", controllers.GetRegularTasks())
	incomingRoutes.DELETE("/delete/:id", controllers.DeleteTask())
	incomingRoutes.POST("/search", controllers.SearchTask())
}
