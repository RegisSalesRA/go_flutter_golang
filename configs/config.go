package configs

import (
	"log"
	"os"

	"github.com/joho/godotenv"
	"github.com/spf13/viper"
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

// É a funcção que inicia na hora que o projeto starta
func init() {
	viper.SetDefault("api.port", "9000")
	viper.SetDefault("database.host", "localhost")
	viper.SetDefault("database.port", "5432")
}

func Load() error {
	viper.SetConfigName("config")
	viper.SetConfigType("toml")
	viper.AddConfigPath(".")

	err := viper.ReadInConfig()

	if err != nil {
		if _, ok := err.(viper.ConfigFileNotFoundError); !ok {
			return err
		}
	}

	enviromentEnv := godotenv.Load(".env")
	if enviromentEnv != nil {
		log.Fatalf("Erro ao carregar arquivo .env: %v", enviromentEnv)
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
