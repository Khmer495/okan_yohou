package weathernews

import (
	"os"

	"go.uber.org/zap"
)

var apiEndpoint = func() string {
	val, ok := os.LookupEnv("WEATHER_NEWS_API_ENDPOINT")
	if !ok {
		zap.L().Panic(`os.LookupEnv("WEATHER_NEWS_API_ENDPOINT")`)
	}
	return val
}()

var apiKey = func() string {
	val, ok := os.LookupEnv("WEATHER_NEWS_API_KEY")
	if !ok {
		zap.L().Panic(`os.LookupEnv("WEATHER_NEWS_API_KEY")`)
	}
	return val
}()
