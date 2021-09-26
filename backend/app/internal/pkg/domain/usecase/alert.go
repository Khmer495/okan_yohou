package usecase

import (
	"context"
	"fmt"

	"github.com/Khmer495/okan_yohou/internal/pkg/domain/entity"
	"github.com/Khmer495/okan_yohou/internal/pkg/domain/repository"
	"github.com/Khmer495/okan_yohou/internal/pkg/infrastracture/line"
	"github.com/Khmer495/okan_yohou/internal/pkg/infrastracture/weathernews"
	"github.com/Khmer495/okan_yohou/internal/pkg/util/cerror"
)

type IAlertUsecase interface {
	Register(ctx context.Context, title string, lat float64, lon float64, wx *int, temp *float64, arpress *int, wndspd *int, rhum *int, feeltmp *int, text string) (*entity.Alert, error)
	List(ctx context.Context, limit *int, page *int) (entity.Alerts, error)
	Change(ctx context.Context, alertId string, title *string, lat *float64, lon *float64, wx *int, temp *float64, arpress *int, wndspd *int, rhum *int, feeltmp *int, text *string) (*entity.Alert, error)
	Delete(ctx context.Context, alertId string) error
	Notify(ctx context.Context, alertId string) error
}

type alertUsecase struct {
	ar repository.IAlertRepository
}

func NewAlertUsecase(ar repository.IAlertRepository) IAlertUsecase {
	return alertUsecase{
		ar: ar,
	}
}

func (au alertUsecase) Register(ctx context.Context, title string, lat float64, lon float64, wx *int, temp *float64, arpress *int, wndspd *int, rhum *int, feeltmp *int, text string) (*entity.Alert, error) {
	alert, err := entity.InitAlert(title, lat, lon, wx, temp, arpress, wndspd, rhum, feeltmp, text)
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

func (au alertUsecase) Change(ctx context.Context, alertIdString string, title *string, latFloat *float64, lonFloat *float64, wx *int, temp *float64, arpress *int, wndspd *int, rhum *int, feeltmp *int, text *string) (*entity.Alert, error) {
	alertId, err := entity.NewId(alertIdString)
	if err != nil {
		return nil, parseEntityConstractorError(err, "entity.NewId")
	}
	alert, err := au.ar.One(ctx, *alertId)
	if err != nil {
		return nil, cerror.WrapNotFoundError(err, "au.ar.One", "指定のアラートが存在しません。")
	}
	if title != nil {
		err := alert.SetTitle(*title)
		if err != nil {
			return nil, parseEntityConstractorError(err, "alert.SetTitle")
		}
	}
	if latFloat != nil {
		err := alert.SetLat(*latFloat)
		if err != nil {
			return nil, parseEntityConstractorError(err, "alert.SetLat")
		}
	}
	if lonFloat != nil {
		err := alert.SetLon(*lonFloat)
		if err != nil {
			return nil, parseEntityConstractorError(err, "alert.SetLon")
		}
	}
	if wx != nil {
		err := alert.SetWx(*wx)
		if err != nil {
			return nil, parseEntityConstractorError(err, "alert.SetWx")
		}
	}
	if temp != nil {
		err := alert.SetTemp(*temp)
		if err != nil {
			return nil, parseEntityConstractorError(err, "alert.SetTemp")
		}
	}
	if arpress != nil {
		err := alert.SetArpress(*arpress)
		if err != nil {
			return nil, parseEntityConstractorError(err, "alert.SetArpress")
		}

	}
	if wndspd != nil {
		err := alert.SetWndspd(*wndspd)
		if err != nil {
			return nil, parseEntityConstractorError(err, "alert.SetWndspd")
		}
	}
	if rhum != nil {
		err := alert.SetRhum(*rhum)
		if err != nil {
			return nil, parseEntityConstractorError(err, "alert.SetRhum")
		}
	}
	if feeltmp != nil {
		err := alert.SetFeeltmp(*feeltmp)
		if err != nil {
			return nil, parseEntityConstractorError(err, "alert.SetFeeltmp")
		}
	}
	if text != nil {
		err := alert.SetText(*text)
		if err != nil {
			return nil, parseEntityConstractorError(err, "alert.SetText")
		}
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

func (au alertUsecase) Notify(ctx context.Context, alertIdString string) error {
	alertId, err := entity.NewId(alertIdString)
	if err != nil {
		return parseEntityConstractorError(err, "entity.NewId")
	}
	alert, err := au.ar.One(ctx, *alertId)
	if err != nil {
		return cerror.WrapInternalServerError(err, "au.ar.One")
	}
	forcast, err := weathernews.Forcast(alert.Lat(), alert.Lon())
	if err != nil {
		return cerror.WrapInternalServerError(err, "weathernews.Forcast")
	}
	// nowAt := time.Now()
	// nowYMDH_JST := time.Date(nowAt.Year(), nowAt.Month(), nowAt.Day(), nowAt.Hour(), 0, 0, 0, util.JST)
	srf := forcast.Wxdata[0].Srfs[0]

	// ここから------デモ用に消している
	// flag := alert.PArpress().IsTriggered(srf.Arpress) &&
	// 	alert.PFeeltmp().IsTriggered(srf.Feeltmp) &&
	// 	alert.PRhum().IsTriggered(srf.Rhum) &&
	// 	alert.PTemp().IsTriggered(srf.Temp) &&
	// 	alert.PWndspd().IsTriggered(srf.Wndspd) &&
	// 	alert.PWx().IsTriggered(srf.Wx)
	// if !flag {
	// 	return nil
	// }
	// ここまで------デモ用に消している

	message := fmt.Sprintf("Title: %s\nText: %s\n気圧: %g\n体感気温: %g\n湿度: %d\n気温: %g\n風速: %g\n天気: %d", alert.Title(), alert.Text(),
		srf.Arpress, srf.Feeltmp, srf.Rhum, srf.Temp, srf.Wndspd, srf.Wx)
	err = line.PushMessage(message)
	if err != nil {
		return cerror.WrapInternalServerError(err, "line.PushMessages")
	}

	return nil
}
