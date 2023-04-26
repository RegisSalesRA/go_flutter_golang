package data

import (
	"server/db"
)

func UpdateDataDone(id int64, done bool) (int64, error) {

	conn, err := db.OpenConnection()
	if err != nil {
		return 0, err
	}
	defer conn.Close()

	res, err := conn.Exec(`UPDATE tasks SET done=$1 WHERE id=$2`, done, id)
	if err != nil {
		return 0, err
	}
	return res.RowsAffected()
}
