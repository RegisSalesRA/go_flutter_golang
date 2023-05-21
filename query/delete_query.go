package repository

import (
	"encoding/json"
	"log"
	"net/http"
	"server/data"
	"strconv"

	"github.com/go-chi/chi/v5"
)

func Delete(w http.ResponseWriter, r *http.Request) {
	id, err := strconv.Atoi(chi.URLParam(r, "id"))

	if err != nil {
		log.Printf("Erro ao fazer decode do json: %v", err)
		http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
		return
	}

	rows, err := data.Delete(int64(id))
	if err != nil {
		log.Printf("Erro ao fazer decode do json: %v", err)
		http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
		return
	}

	if rows > 1 {
		log.Printf("Erro: foram deletar mais de um registro: %d", rows)
	}

	resp := map[string]any{
		"Error":   false,
		"MEssage": "Dados deletar com sucesso!",
	}
	w.Header().Add("Content-Type", "application/json")
	json.NewEncoder(w).Encode(resp)
}
