package data

import (
	"server/db"
	"server/models"
)

func GetAll() (tasks []models.Task, err error) {

	conn, err := db.OpenConnection()
	if err != nil {
		return
	}
	defer conn.Close()

	rows, err := conn.Query(`SELECT * FROM tasks`)
	if err != nil {
		return
	}

	for rows.Next() {
		var task models.Task
		err = rows.Scan(&task.ID, &task.Title, &task.Description, &task.Done, &task.CreatedAt)
		if err != nil {
			continue
		}
		tasks = append(tasks, task)
	}

	return
}
