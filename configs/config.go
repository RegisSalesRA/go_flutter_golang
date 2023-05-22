package configs

import (
	"log"
	"os"

	"github.com/joho/godotenv"
)

// Fazendo um ponteiro ninguem fora desse package pode acessar o config
var cfg *config

type config struct {
	API APIConfig
	DB  DBConfig
}

type APIConfig struct {
	Port string
}

type DBConfig struct {
	Host     string
	Port     string
	User     string
	Pass     string
	Database string
}

func Load() error {

	enviromentEnv := godotenv.Load(".env")
	if enviromentEnv != nil {
		log.Fatalf("Error fail to loading file .env: %v", enviromentEnv)
	}

	cfg = new(config)

	cfg.API = APIConfig{
		Port: os.Getenv("PORT"),
	}

	cfg.DB = DBConfig{
		Host:     os.Getenv("HOST"),
		Port:     os.Getenv("DATABASEPORT"),
		User:     os.Getenv("DBUSER"),
		Pass:     os.Getenv("PASS"),
		Database: os.Getenv("DBNAME"),
	}
	return nil
}

func GetDB() DBConfig {
	return cfg.DB
}

func GetServerPort() string {
	return cfg.API.Port
}
