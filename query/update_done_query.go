package query

import (
	"encoding/json"
	"fmt"
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

	body, err := ioutil.ReadAll(r.Body)
	if err != nil {
		http.Error(w, "Error cant not read body request", http.StatusBadRequest)
		return
	}

	if err := json.Unmarshal(body, &datab); err != nil {
		http.Error(w, "Error for loading request body", http.StatusBadRequest)
		return
	}

	doneBody := datab["done"].(bool)

	log.Printf("value request: %v", doneBody)

	rows, err := data.UpdateDataDone(int64(id), doneBody)
	if rows > 1 {
		log.Printf("Erro: more then one tasks was registed: %d", rows)
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
			"Message": fmt.Sprintf("task updated task with success! ID: %d", id),
		}
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
	}
	w.Header().Add("Content-Type", "application/json")
	json.NewEncoder(w).Encode(resp)
}
