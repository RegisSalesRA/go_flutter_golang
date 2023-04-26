package main

import (
	"fmt"
	"net/http"
	"server/configs"
	"server/repository"

	"github.com/go-chi/chi/v5"
)

func main() {
	err := configs.Load()
	if err != nil {
		panic(err)
	}

	r := chi.NewRouter()
	r.Post("/", repository.Create)
	r.Put("/{id}", repository.Update)
	r.Put("/done/{id}", repository.UpdateDataDone)
	r.Delete("/", repository.Delete)
	r.Get("/", repository.List)
	r.Get("/{id}", repository.Get)

	http.ListenAndServe(fmt.Sprintf(":%s", configs.GetServerPort()), r)

}
