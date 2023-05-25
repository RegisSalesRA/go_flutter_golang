package query

import (
	"encoding/json"
	"fmt"
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
		log.Printf("Error made decode json: %v", err)
		http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
		return
	}

	if id == 0 {
		http.Error(w, "ID inválido", http.StatusBadRequest)
		return
	}

	if err == ErrNotFound {
		http.Error(w, "Tarefa não encontrada", http.StatusNotFound)
		return
	}

	var task models.Task

	err = json.NewDecoder(r.Body).Decode(&task)
	if err != nil {
		log.Printf("Error made decode json")
		http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
		return
	}

	if task.Title == "" || task.Description == "" {
		resp := map[string]interface{}{
			"Error":   true,
			"Message": "Empty title or description field",
		}

		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusBadRequest)
		json.NewEncoder(w).Encode(resp)
		return
	}

	rows, err := data.Update(int64(id), task)
	if rows > 1 {
		log.Printf("Erro: was updated more then one taks: %d", rows)
	}
	var resp map[string]any
	if err != nil {
		resp = map[string]interface{}{
			"Error":   true,
			"Message": fmt.Sprintf("Can not find thid ID: %v", err),
		}

		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusNotFound)
	} else {
		resp = map[string]interface{}{
			"Error":   false,
			"Message": fmt.Sprintf("task deleted with success! ID: %d", id),
		}
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
	}

 
	w.Header().Add("Content-Type", "application/json")
	json.NewEncoder(w).Encode(resp)
}
