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
	r.Get("/", query.List)
	r.Get("/{id}", query.Get)

	r.Post("/", query.Create)

	r.Put("/{id}", query.Update)
	r.Put("/done/{id}", query.UpdateDataDone)

	r.Delete("/{id}", query.Delete)


	http.ListenAndServe(fmt.Sprintf(":%s", configs.GetServerPort()), r)

}
