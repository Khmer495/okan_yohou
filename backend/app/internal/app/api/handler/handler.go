package handler

import (
	"net/http"

	"github.com/Khmer495/okan_yohou/internal/app/api/openapi"
	"github.com/Khmer495/okan_yohou/internal/pkg/domain/entity"
	"github.com/Khmer495/okan_yohou/internal/pkg/domain/usecase"
	"github.com/Khmer495/okan_yohou/internal/pkg/util/cerror"
	"github.com/labstack/echo/v4"
	"go.uber.org/zap"
)

type handler struct {
	au usecase.IAlertUsecase
}

func NewHandler(au usecase.IAlertUsecase) openapi.ServerInterface {
	return handler{
		au: au,
	}
}

func fromEntityAlertToOpenapiAlert(alert entity.Alert) openapi.Alert {
	return openapi.Alert{
		Arpress: alert.PArpress(),
		Feeltmp: alert.PFeeltmp(),
		Id:      alert.Id().Ulid().String(),
		Lat:     alert.Lat(),
		Lon:     alert.Lon(),
		Rhum:    alert.PRhum(),
		Temp:    alert.PTemp(),
		Text:    alert.Text(),
		Title:   alert.Title(),
		Wndspd:  alert.PWndspd(),
		Wx:      alert.PWx(),
	}
}

func fromEntityAlertsToOpenapiAlerts(as entity.Alerts) []openapi.Alert {
	alerts := []openapi.Alert{}
	for _, a := range as {
		alerts = append(alerts, fromEntityAlertToOpenapiAlert(*a))
	}
	return alerts
}

func (h handler) GetAlerts(ctx echo.Context, params openapi.GetAlertsParams) error {
	alerts, err := h.au.List(ctx.Request().Context(), params.Limit, params.Page)
	if err != nil {
		zap.S().Errorf("h.au.List: %+v", err)
		if cerror.IsCode(err, cerror.InvalidArgumentErrorCode) {
			return NewInvalidArgumentError(ctx, cerror.As(err).ClientMsg())
		}
		return NewInternalServerError(ctx)
	}
	res := fromEntityAlertsToOpenapiAlerts(alerts)
	return ctx.JSON(http.StatusOK, res)
}

func (h handler) PostAlerts(ctx echo.Context) error {
	req := openapi.PostAlertsJSONRequestBody{}
	if err := ctx.Bind(&req); err != nil {
		zap.S().Errorf("ctx.Bind: %+v", err)
		return NewInvalidRequestFormatError(ctx, err)
	}
	alert, err := h.au.Register(ctx.Request().Context(), req.Title, req.Lat, req.Lon, req.Wx, req.Temp, req.Arpress, req.Wndspd, req.Rhum, req.Feeltmp, req.Text)
	if err != nil {
		zap.S().Errorf("h.au.Change: %+v", err)
		if cerror.IsCode(err, cerror.InvalidArgumentErrorCode) {
			return NewInvalidArgumentError(ctx, cerror.As(err).ClientMsg())
		}
		return NewInternalServerError(ctx)
	}
	res := fromEntityAlertToOpenapiAlert(*alert)
	return ctx.JSON(http.StatusCreated, res)
}

func (h handler) DeleteAlertsAlertId(ctx echo.Context, alertId string) error {
	err := h.au.Delete(ctx.Request().Context(), alertId)
	if err != nil {
		zap.S().Errorf("h.au.Delete: %+v", err)
		if cerror.IsCode(err, cerror.InvalidArgumentErrorCode) {
			return NewInvalidArgumentError(ctx, cerror.As(err).ClientMsg())
		}
		return NewInternalServerError(ctx)
	}
	return ctx.NoContent(http.StatusNoContent)
}

func (h handler) PutAlertsAlertId(ctx echo.Context, alertId string) error {
	req := openapi.PutAlertsAlertIdJSONRequestBody{}
	if err := ctx.Bind(&req); err != nil {
		zap.S().Errorf("ctx.Bind: %+v", err)
		return NewInvalidRequestFormatError(ctx, err)
	}
	alert, err := h.au.Change(ctx.Request().Context(), alertId, req.Title, req.Lat, req.Lon, req.Wx, req.Temp, req.Arpress, req.Wndspd, req.Rhum, req.Feeltmp, req.Text)
	if err != nil {
		zap.S().Errorf("h.au.Change: %+v", err)
		if cerror.IsCode(err, cerror.InvalidArgumentErrorCode) {
			return NewInvalidArgumentError(ctx, cerror.As(err).ClientMsg())
		}
		return NewInternalServerError(ctx)
	}
	res := fromEntityAlertToOpenapiAlert(*alert)
	return ctx.JSON(http.StatusOK, res)
}
