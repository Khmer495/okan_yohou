package echo

import (
	"fmt"
	"net/http"

	"github.com/Khmer495/okan_yohou/internal/app/api/appconfig"
	"github.com/Khmer495/okan_yohou/internal/app/api/openapi"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func bodyDumpHandler(c echo.Context, reqBody, resBody []byte) {
	fmt.Printf("Request Body: %v\nResponse Body: %v\n", string(reqBody), string(resBody))
}

func NewEchoServer(openapiHandler openapi.ServerInterface) {
	e := echo.New()
	e.Use(middleware.Recover())
	e.Use(middleware.CORS())
	// now := time.Now().UTC().In(time.FixedZone("Asia/Tokyo", 9*60*60)).Format("20060102150405")
	// file, err := os.OpenFile("./logfile/"+now+".log", os.O_WRONLY|os.O_CREATE|os.O_TRUNC, 0644)
	// if err != nil {
	// 	panic(err)
	// }
	// e.Use(middleware.LoggerWithConfig(middleware.LoggerConfig{
	// 	Output: file,
	// }))
	e.Use(middleware.Logger())
	e.Use(middleware.BodyDump(bodyDumpHandler))

	e.GET("/health", func(c echo.Context) error { return c.NoContent(http.StatusOK) })
	openapi.RegisterHandlers(e, openapiHandler)

	e.Logger.Panic(e.Start(fmt.Sprintf("0.0.0.0:%s", appconfig.RestPort)))
}
