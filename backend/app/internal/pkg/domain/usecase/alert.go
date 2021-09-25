package usecase

import (
	"context"

	"github.com/Khmer495/okan_yohou/internal/pkg/domain/entity"
	"github.com/Khmer495/okan_yohou/internal/pkg/domain/repository"
	"github.com/Khmer495/okan_yohou/internal/pkg/util/cerror"
)

type IAlertUsecase interface {
	Register(ctx context.Context, title string, lat float32, lon float32, wx *int, temp *float32, arpress *int, wndspd *int, rhum *int, feeltmp *int, text string) (*entity.Alert, error)
	List(ctx context.Context, limit *int, page *int) (entity.Alerts, error)
	Change(ctx context.Context, alertId string, title *string, lat *float32, lon *float32, wx *int, temp *float32, arpress *int, wndspd *int, rhum *int, feeltmp *int, text *string) (*entity.Alert, error)
	Delete(ctx context.Context, alertId string) error
}

type alertUsecase struct {
	ar repository.IAlertRepository
}

func NewAlertUsecase(ar repository.IAlertRepository) IAlertUsecase {
	return alertUsecase{
		ar: ar,
	}
}

func (au alertUsecase) Register(ctx context.Context, title string, lat float32, lon float32, wx *int, temp *float32, arpress *int, wndspd *int, rhum *int, feeltmp *int, text string) (*entity.Alert, error) {
	alert, err := entity.NewAlert(text, lat, lat, wx, temp, arpress, wndspd, rhum, feeltmp, text)
	if err != nil {
		return nil, parseEntityConstractorError(err, "entity.NewAlert")
	}
	err = au.ar.Create(ctx, *alert)
	if err != nil {
		return nil, cerror.WrapInternalServerError(err, "au.ar.Create")
	}
	return alert, nil
}

func (au alertUsecase) List(ctx context.Context, limit *int, page *int) (entity.Alerts, error) {
	alerts, err := au.ar.List(ctx, limit, page)
	if err != nil {
		return nil, cerror.WrapInternalServerError(err, "au.ar.List")
	}
	return alerts, nil
}

func (au alertUsecase) Change(ctx context.Context, alertIdString string, title *string, lat *float32, lon *float32, wx *int, temp *float32, arpress *int, wndspd *int, rhum *int, feeltmp *int, text *string) (*entity.Alert, error) {
	alertId, err := entity.NewId(alertIdString)
	if err != nil {
		return nil, parseEntityConstractorError(err, "entity.NewId")
	}
	alert, err := au.ar.One(ctx, *alertId)
	if err != nil {
		return nil, cerror.WrapNotFoundError(err, "au.ar.One", "指定のアラートが存在しません。")
	}
	if title != nil {
		alert.SetTitle(*title)
	}
	if lat != nil {
		alert.SetLat(*lat)
	}
	if lon != nil {
		alert.SetLon(*lon)
	}
	if wx != nil {
		alert.SetWx(*wx)
	}
	if temp != nil {
		alert.SetTemp(*temp)
	}
	if arpress != nil {
		alert.SetArpress(*arpress)
	}
	if wndspd != nil {
		alert.SetWndspd(*wndspd)
	}
	if rhum != nil {
		alert.SetRhum(*rhum)
	}
	if feeltmp != nil {
		alert.SetFeeltmp(*feeltmp)
	}
	if text != nil {
		alert.SetText(*text)
	}
	err = au.ar.Update(ctx, *alert)
	if err != nil {
		return nil, cerror.WrapInternalServerError(err, "au.ar.Update")
	}
	return alert, nil
}

func (au alertUsecase) Delete(ctx context.Context, alertIdString string) error {
	alertId, err := entity.NewId(alertIdString)
	if err != nil {
		return parseEntityConstractorError(err, "entity.NewId")
	}
	err = au.ar.Delete(ctx, *alertId)
	if err != nil {
		return cerror.WrapInternalServerError(err, "au.ar.Delete")
	}
	return nil
}
