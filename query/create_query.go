package query

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
		log.Printf("Error made decode json")
		http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
		return
	}

	if task.Title == "" || task.Description == "" {
		resp := map[string]interface{}{
			"Error":   true,
			"Message": "Fields can not be null or empty",
		}

		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusBadRequest)
		json.NewEncoder(w).Encode(resp)
		return
	}

	id, err := data.Insert(task)

	var resp map[string]any

	if err != nil {
		resp = map[string]any{
			"Error":   true,
			"Message": fmt.Sprintf("Error to insert task to database: %v", err),
		}

	} else {
		resp = map[string]any{
			"Error":   false,
			"Message": fmt.Sprintf("task created with success! ID: %d", id),
		}
	}
	w.Header().Add("Content-Type", "application/json")
	json.NewEncoder(w).Encode(resp)
}
