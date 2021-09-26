package di

import (
	"github.com/Khmer495/okan_yohou/internal/app/api/handler"
	"github.com/Khmer495/okan_yohou/internal/app/api/infrastructure/echo"
	"github.com/Khmer495/okan_yohou/internal/pkg/domain/repository"
	"github.com/Khmer495/okan_yohou/internal/pkg/domain/usecase"
	"go.uber.org/dig"
	"go.uber.org/zap"
)

func newPanic(err error) {
	zap.S().Panicf("di: %+v", err)
}

func provideRepository(d *dig.Container) {
	if err := d.Provide(repository.NewAlertRepository); err != nil {
		newPanic(err)
	}
}

func provideUsecase(d *dig.Container) {
	if err := d.Provide(usecase.NewAlertUsecase); err != nil {
		newPanic(err)
	}
}

func provideHandler(d *dig.Container) {
	if err := d.Provide(handler.NewHandler); err != nil {
		newPanic(err)
	}
}

func invokeEchoServer(d *dig.Container) {
	if err := d.Invoke(echo.NewEchoServer); err != nil {
		newPanic(err)
	}
}

func NewDig() *dig.Container {
	d := dig.New()
	provideRepository(d)
	provideUsecase(d)
	provideHandler(d)
	invokeEchoServer(d)
	return d
}
