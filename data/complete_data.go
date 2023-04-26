package data

import (
	"server/db"
	"server/models"
)

func CompleteTask(id int64, task models.Task) (int64, error) {

	conn, err := db.OpenConnection()
	if err != nil {
		return 0, err
	}
	defer conn.Close()

	res, err := conn.Exec(`UPDATE task SET title=$1, description=$2, done=$3 WHERE id=$4`, task.Title, task.Description, task.Done, task.ID)
	if err != nil {
		return 0, err
	}
	return res.RowsAffected()

}
