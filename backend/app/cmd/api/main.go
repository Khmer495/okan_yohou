package main

import (
	"github.com/Khmer495/okan_yohou/internal/app/api/util/di"
	"github.com/Khmer495/okan_yohou/internal/pkg/domain/repository"
	"github.com/Khmer495/okan_yohou/internal/pkg/util/logger"
	_ "github.com/go-sql-driver/mysql"
	"go.uber.org/zap"
)

func init() {
	logger.NewLogger()
	repository.NewMysqlClient()
}

func main() {
	zap.L().Info("Start Server.")
	di.NewDig()
	defer repository.MysqlClient.Close()
}
