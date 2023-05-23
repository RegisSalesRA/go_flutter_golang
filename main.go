package main

import (
	"fmt"
	"net/http"
	"server/configs"
	"server/query"

	"github.com/go-chi/chi/v5"
)

func main() {
	err := configs.Load()
	if err != nil {
		panic(err)
	}

	r := chi.NewRouter()
	r.Get("/tasks/", query.List)
	r.Get("/tasks/{id}", query.Get)

	r.Post("/tasks/", query.Create)

	r.Put("/tasks/{id}", query.Update)
	r.Put("/tasks/done/{id}", query.UpdateDataDone)

	r.Delete("/tasks/{id}", query.Delete)

	http.ListenAndServe(fmt.Sprintf(":%s", configs.GetServerPort()), r)

}
