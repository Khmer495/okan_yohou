package logger

import (
	"go.uber.org/zap"
)

func NewLogger() {
	logger, err := zap.NewDevelopment()
	if err != nil {
		logger.Sugar().Panicf("zap.NewDevelopment: %+v", err)
	}
	zap.ReplaceGlobals(logger)
	zap.L().Info("Complete setting up zap logger.")
}
