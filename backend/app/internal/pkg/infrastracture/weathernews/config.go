package weathernews

import (
	"os"

	"go.uber.org/zap"
)

var apiEndpoint = func() string {
	key, ok := os.LookupEnv("WEATHER_NEWS_API_ENDPOINT")
	if !ok {
		zap.L().Fatal(`os.LookupEnv("WEATHER_NEWS_API_ENDPOINT")`)
	}
	return key
}()

var apiKey = func() string {
	key, ok := os.LookupEnv("WEATHER_NEWS_API_KEY")
	if !ok {
		zap.L().Fatal(`os.LookupEnv("WEATHER_NEWS_API_KEY")`)
	}
	return key
}()
