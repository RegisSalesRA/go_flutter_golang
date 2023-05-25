package query

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
		log.Printf("Error made decode json: %v", err)
		http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
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
	if err != nil {
		log.Printf("Error made decode json: %v", err)
		http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
		return
	}

	if rows > 1 {
		log.Printf("Erro: more then one tasks was registed: %d", rows)
	}

	resp := map[string]any{
		"Error":   false,
		"Message": "Task done update with success!",
	}
	w.Header().Add("Content-Type", "application/json")
	json.NewEncoder(w).Encode(resp)
}
