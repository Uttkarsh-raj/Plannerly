package models

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type Task struct {
	ID          primitive.ObjectID `bson:"_id"`
	User_id     *string            `json:"user_id"`
	Title       *string            `json:"title"`
	Description *string            `json:"desc"`
	Time        *string            `json:"time"`
	Date        *string            `json:"date"`
	Completed   bool               `json:"completed"`
}
