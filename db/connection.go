package db

import (
	"database/sql"
	"fmt"
	"server/configs"

	_ "github.com/lib/pq"
)

// 17:40

func OpenConnection() (*sql.DB, error) {
	conf := configs.GetDB()

	sc := fmt.Sprintf("host=%s port=%s password=%s dbname=%s sslmode=disable",
		conf.Host, conf.Port, conf.User, conf.Pass, conf.Database,
	)

	conn, err := sql.Open("postgres", sc)
	if err != nil {
		// em produção não é indicado
		panic(err)
	}

	err = conn.Ping()

	return conn, err

}
