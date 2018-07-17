package main

import (
	"flag"
	"fmt"
	"net/http"
)

func main() {
	host := flag.String("host", "localhost", "Host to bind to, e.g. localhost or 127.0.0.1")
	port := flag.String("port", "8081", "Port to bind to")
	msg := flag.String("msg", "Hello, World!", "Message to return for every request")
	flag.Parse()

	addr := *host + ":" + *port
	fmt.Println("Listening on " + addr)

	server := &http.Server{
		Addr: addr,
		Handler: http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			handleHTTP(w, r, *msg)
		}),
	}

	if err := server.ListenAndServe(); err != nil {
		panic("Could not start http server")
	}
}

func handleHTTP(w http.ResponseWriter, r *http.Request, msg string) {
	w.Write([]byte(msg))
}
