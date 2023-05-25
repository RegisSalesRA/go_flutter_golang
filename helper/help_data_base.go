package main

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/lib/pq"
)

func main() {

	db, err := sql.Open("postgres", "postgres://user:password@localhost:5432/?sslmode=disable")
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	_, err = db.Exec("CREATE DATABASE tasks")
	if err != nil {
		log.Fatal(err)
	}

	db, err = sql.Open("postgres", "postgres://user:password@localhost:5432/tasks?sslmode=disable")
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	_, err = db.Exec(`
		CREATE TABLE tasks (
			id SERIAL PRIMARY KEY,
			title VARCHAR(255) NOT NULL,
			description TEXT,
			done BOOLEAN DEFAULT FALSE,
			created_at TIMESTAMP DEFAULT NOW()
		)
	`)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("Created database wiith success!")
}