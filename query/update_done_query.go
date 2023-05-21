package repository

import (
	"encoding/json"
	"io/ioutil"
	"log"
	"net/http"
	"server/data"
	"strconv"

	"github.com/go-chi/chi/v5"
)

func UpdateDataDone(w http.ResponseWriter, r *http.Request) {
	var datab map[string]interface{}
	id, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("Erro ao fazer decode do json: %v", err)
		http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
		return
	}

	body, err := ioutil.ReadAll(r.Body)
	if err != nil {
		http.Error(w, "Erro ao ler o corpo da solicitação", http.StatusBadRequest)
		return
	}

	if err := json.Unmarshal(body, &datab); err != nil {
		http.Error(w, "Erro ao analisar o corpo da solicitação", http.StatusBadRequest)
		return
	}

	doneBody := datab["done"].(bool)

	log.Printf("value request: %v", doneBody)

	rows, err := data.UpdateDataDone(int64(id), doneBody)
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
		"Message": "Dados atualizados com sucesso!",
	}
	w.Header().Add("Content-Type", "application/json")
	json.NewEncoder(w).Encode(resp)
}
