package line

import (
	"os"

	"go.uber.org/zap"
)

var channelSecret = func() string {
	val, ok := os.LookupEnv("LINE_CHANNEL_SECRET")
	if !ok {
		zap.L().Panic(`os.LookupEnv("LINE_CHANNEL_SECRET")`)
	}
	return val
}()

var channelToken = func() string {
	val, ok := os.LookupEnv("CHANNEL_TOKEN")
	if !ok {
		zap.L().Panic(`os.LookupEnv("CHANNEL_TOKEN")`)
	}
	return val
}()
