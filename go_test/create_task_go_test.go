package go_test

import (
	"server/data"
	"server/models"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestCompleteTask(t *testing.T) {

	task := models.Task{
		ID:          1,
		Title:       "Tarefa",
		Description: "Descrição da tarefa",
		Done:        true,
	}

	rowsAffected, err := data.CompleteTask(task.ID, task)

	assert.NoError(t, err) 
	assert.Equal(t, int64(1), rowsAffected, "O número de linhas afetadas deve ser 1")
}
