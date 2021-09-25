package ent

import (
	"github.com/Khmer495/okan_yohou/internal/pkg/domain/entity"
	"golang.org/x/xerrors"
)

func (a Alert) EntityAlert() (*entity.Alert, error) {
	alert, err := entity.NewAlert(a.Title, a.Lat, a.Lon, a.Wx, a.Temp, a.Arpress, a.Wndspd, a.Rhum, a.Feeltmp, a.Text)
	if err != nil {
		return nil, xerrors.Errorf("entity.NewAlert: %w", err)
	}
	return alert, nil
}

func (as Alerts) NewEntityAlerts() (entity.Alerts, error) {
	alerts := entity.Alerts{}
	for _, a := range as {
		alert, err := a.EntityAlert()
		if err != nil {
			return nil, xerrors.Errorf("a.EntityAlert: %w", err)
		}
		alerts = append(alerts, alert)
	}
	return alerts, nil
}
