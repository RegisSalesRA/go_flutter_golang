package data

import (
	"server/db"
	"server/models"
)

func Get(id int64) (task models.Task, err error) {

	conn, err := db.OpenConnection()
	if err != nil {
		return
	}
	defer conn.Close()

	row := conn.QueryRow(`SELECT * FROM tasks WHERE id=$1`, id)

	err = row.Scan(&task.ID, &task.Title, &task.Description, &task.Done, &task.CreatedAt)

	return
}
