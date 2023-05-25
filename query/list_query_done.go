package query

import (
	"encoding/json"
	"log"
	"net/http"
	"server/data"
)

func ListDone(w http.ResponseWriter, r *http.Request) {
	tasks, err := data.GetAllDone()

	if err != nil {
		log.Printf("Error to get tasks from database: %v", err)
	}

	w.Header().Add("Content-Type", "application/json")
	json.NewEncoder(w).Encode(tasks)

}
