package di

import (
	"github.com/Khmer495/okan_yohou/internal/app/api/infrastructure/echo"
	"go.uber.org/dig"
	"go.uber.org/zap"
)

func newPanic(err error) {
	zap.S().Panicf("di: %+v", err)
}

func provideService(d *dig.Container) {

}

func provideRepository(d *dig.Container) {

}

func provideUsecase(d *dig.Container) {

}

func provideHandler(d *dig.Container) {

}

func invokeEchoServer(d *dig.Container) {
	if err := d.Invoke(echo.NewEchoServer); err != nil {
		newPanic(err)
	}
}

func NewDig() *dig.Container {
	d := dig.New()
	provideService(d)
	provideRepository(d)
	provideUsecase(d)
	invokeEchoServer(d)
	return d
}
