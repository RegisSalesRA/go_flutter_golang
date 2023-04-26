package repository

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"server/data"
	"server/models"
)

func Create(w http.ResponseWriter, r *http.Request) {
	var task models.Task

	err := json.NewDecoder(r.Body).Decode(&task)
	if err != nil {
		log.Printf("Erro ao fazer decode do json")
		http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
		return
	}

	id, err := data.Insert(task)

	var resp map[string]any

	if err != nil {
		resp = map[string]any{
			"Error":   true,
			"Message": fmt.Sprintf("Ocorreu um erro ao tentar inserir: %v", err),
		}

	} else {
		resp = map[string]any{
			"Error":   false,
			"Message": fmt.Sprintf("task inserido com sucesso! ID: %d", id),
		}
	}
	w.Header().Add("Content-Type", "application/json")
	json.NewEncoder(w).Encode(resp)
}
