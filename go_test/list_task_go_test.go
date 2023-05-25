package go_test

import (
	"errors"
	"net/http"
	"net/http/httptest"
	"reflect"
	"server/data"
	"server/models"
	"testing"
)

type Tests struct {
	name          string
	server        *httptest.Server
	response      *models.Task
	expectedError error
}

func TestGetWeather(t *testing.T) {

	tests := []Tests{
		{
			name: "basic-request",
			server: httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				w.WriteHeader(http.StatusOK)
				w.Write([]byte(`{ "city": "Denver, CO", "forecast": "sunny"}`))
			})),
			response: &models.Task{
				Title:       "Denver, CO",
				Description: "sunny",
			},
			expectedError: nil,
		},
	}
	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			defer test.server.Close()

			resp, err := data.GetAll()

			if !reflect.DeepEqual(resp, test.response) {
				t.Errorf("FAILED: expected %v, got %v\n", test.response, resp)
			}
			if !errors.Is(err, test.expectedError) {
				t.Errorf("Expected error FAILED: expected %v got %v\n", test.expectedError, err)
			}
		})
	}
}
