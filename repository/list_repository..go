package repository

import (
	"encoding/json"
	"log"
	"net/http"
	"server/data"
)

func List(w http.ResponseWriter, r *http.Request) {
	todos, err := data.GetAll()

	if err != nil {
		log.Printf("Erro ao obter registros do banco: %v", err)
	}

	w.Header().Add("Content-Type", "application/json")
	json.NewEncoder(w).Encode(todos)

}
