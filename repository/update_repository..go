package repository

import (
	"encoding/json"
	"log"
	"net/http"
	"server/data"
	"server/models"
	"strconv"
	"github.com/go-chi/chi/v5"
)

func Update(w http.ResponseWriter, r *http.Request) {
	id, err := strconv.Atoi(chi.URLParam(r, "id"))

	if err != nil {
		log.Printf("Erro ao fazer decode do json: %v", err)
		http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
		return
	}

	var task models.Task

	err = json.NewDecoder(r.Body).Decode(&task)
	if err != nil {
		log.Printf("Erro ao fazer decode do json")
		http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
		return
	}

	rows, err := data.Update(int64(id), task)
	if err != nil {
		log.Printf("Erro ao fazer decode do json: %v", err)
		http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
		return
	}

	if rows > 1 {
		log.Printf("Erro: foram atualizados mais de um registro: %d", rows)
	}

	resp := map[string]any{
		"Error":   false,
		"MEssage": "Dados atualizados com sucesso!",
	}
	w.Header().Add("Content-Type", "application/json")
	json.NewEncoder(w).Encode(resp)
}
