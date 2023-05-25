package data

import (
	"server/db"
	"server/models"
)

func Update(id int64, task models.Task) (int64, error) {

	conn, err := db.OpenConnection()
	if err != nil {
		return 0, err
	}
	defer conn.Close()

	res, err := conn.Exec(`UPDATE tasks SET title=$1, description=$2, done=$3 WHERE id=$4`, task.Title, task.Description, task.Done, id)
	if err != nil {
		return 0, err
	}
	rowsAffected, err := res.RowsAffected()
	if err != nil {
		return 0, err
	}

	if rowsAffected == 0 {
		return 0, ErrNotFoundDelete
	}

	return rowsAffected, nil

}
