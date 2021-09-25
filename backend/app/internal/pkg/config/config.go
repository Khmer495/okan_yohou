package config

import (
	"fmt"
	"os"

	"go.uber.org/zap"
)

func MysqlDSN() string {
	user, ok := os.LookupEnv("MYSQL_USER")
	if !ok {
		zap.L().Fatal(`os.LookupEnv("MYSQL_USER")`)
	}
	password, ok := os.LookupEnv("MYSQL_PASSWORD")
	if !ok {
		zap.L().Fatal(`os.LookupEnv("MYSQL_PASSWORD")`)
	}
	host, ok := os.LookupEnv("MYSQL_HOST")
	if !ok {
		zap.L().Fatal(`os.LookupEnv("MYSQL_HOST")`)
	}
	port, ok := os.LookupEnv("MYSQL_PORT")
	if !ok {
		zap.L().Fatal(`os.LookupEnv("MYSQL_PORT")`)
	}
	db, ok := os.LookupEnv("MYSQL_DATABASE")
	if !ok {
		zap.L().Fatal(`os.LookupEnv("MYSQL_DATABASE")`)
	}
	return fmt.Sprintf("%s:%s@tcp(%s:%s)/%s", user, password, host, port, db)
}
