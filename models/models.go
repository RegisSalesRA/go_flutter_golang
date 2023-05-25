package models

import (
	"database/sql"
)

type Task struct {
	ID          int64        `json:"id"`
	Title       string       `json:"title"`
	Description string       `json:"description"`
	Done        bool         `json:"done"`
	CreatedAt   sql.NullTime `json:"created_at"`
}
