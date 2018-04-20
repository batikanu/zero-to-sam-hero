package main

import (
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
)

// MyEvent is a JSON parser for the event object.
type MyEvent struct {
	Name string `json:"Name"`
	Age  int    `json:"Age"`
}

// MyResponse is an object for creating response object.
type MyResponse struct {
	Message string `json:"Answer"`
}

// HandleLambdaEvent is the handler for our sample lambda events.
func HandleLambdaEvent(event MyEvent) (MyResponse, error) {
	return MyResponse{Message: fmt.Sprintf("%s is %d years old!", event.Name, event.Age)}, nil
}

func main() {
	lambda.Start(HandleLambdaEvent)
}
