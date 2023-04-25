package db

import (
	"database/sql"
	"fmt"
	"log"
	"server/configs"

	_ "github.com/lib/pq"
)

// 17:40

func OpenConnection() (*sql.DB, error) {
	conf := configs.GetDB()

	sc := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=disable", conf.Host, conf.Port, conf.User, conf.Pass, conf.Database)

	conn, err := sql.Open("postgres", sc)
	if err != nil {
		log.Printf("Erro ao objeter registros do banco: %v", err)
		panic(err)
	}

	err = conn.Ping()

	return conn, err

}
