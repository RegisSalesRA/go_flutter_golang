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

var ErrNotFound = errors.New("can not find task")

func Get(w http.ResponseWriter, r *http.Request) {
	id, err := strconv.Atoi(chi.URLParam(r, "id"))

	if id == 0 {
		http.Error(w, "ID inválido", http.StatusBadRequest)
		return
	}

	if err == ErrNotFound {
		log.Printf("Error made decode json: %v", err)
		http.Error(w, "Task no found", http.StatusNotFound)
		return
	}

	if err != nil {
		log.Printf("Error made decode json: %v", err)
		http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
		return
	}

	var resp map[string]any
	task, err := data.Get(int64(id))
	if err != nil {
		resp = map[string]interface{}{
			"Error":   true,
			"Message": fmt.Sprintf("Can not find thid ID: %v", err),
		}
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusNotFound)
		json.NewEncoder(w).Encode(resp)
		return
	}

	w.Header().Add("Content-Type", "application/json")
	json.NewEncoder(w).Encode(task)
}
