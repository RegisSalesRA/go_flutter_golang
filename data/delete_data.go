package data

import (
	"errors"
	"server/db"
)

var ErrNotFoundDelete = errors.New("can not find task")

func Delete(id int64) (int64, error) {

	conn, err := db.OpenConnection()
	if err != nil {
		return 0, err
	}
	defer conn.Close()

	res, err := conn.Exec(`DELETE FROM tasks WHERE id=$1`, id)
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
