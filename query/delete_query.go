package query

import (
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"net/http"
	"server/data"
	"strconv"

	"github.com/go-chi/chi/v5"
)

var ErrNotFoundDelete = errors.New("can not find task")

func Delete(w http.ResponseWriter, r *http.Request) {
	id, err := strconv.Atoi(chi.URLParam(r, "id"))

	if id == 0 {
		http.Error(w, "ID inválido", http.StatusBadRequest)
		return
	}

	if err == ErrNotFoundDelete {
		log.Printf("Error made decode json: %v", err)
		http.Error(w, "Task no found", http.StatusNotFound)
		return
	}

	if err != nil {
		log.Printf("Error made decode json: %v", err)
		http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
		return
	}

	rows, err := data.Delete(int64(id))
	if rows > 1 {
		log.Printf("Erro: more then one register was deleted: %d", rows)
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
