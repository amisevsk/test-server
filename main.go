package main

import (
	"flag"
	"fmt"
	"net/http"
)

func main() {
	var port int
	var message string
	flag.IntVar(&port, "port", 8080, "Port to listen on")
	flag.StringVar(&message, "message", "Hello!", "Message to print in response")
	flag.Parse()

	fmt.Printf("Starting server listening on port %d and responding with message %s\n", port, message)
	http.HandleFunc("/", ResponseFunc(port, message))
	http.ListenAndServe(fmt.Sprintf(":%d", port), nil)
}

func ResponseFunc(port int, message string) func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, _ *http.Request) {
		fmt.Fprintf(w, "%s\nListening on port %d\n", message, port)
	}
}
