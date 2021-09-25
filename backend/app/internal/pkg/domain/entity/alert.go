package entity

import "golang.org/x/xerrors"

type Alert struct {
	title   string
	trigger Trigger
	text    string
}

type Alerts []*Alert

func NewAlert(title string, wx int, temp float64, arpress int, wndspd int, rhum int, feeltmp int, text string) (*Alert, error) {
	trigger, err := NewTrigger(wx, temp, arpress, wndspd, rhum, feeltmp)
	if err != nil {
		return nil, xerrors.Errorf("NewTrigger: %w", err)
	}
	alert := Alert{
		title:   title,
		trigger: *trigger,
		text:    text,
	}
	return &alert, nil
}
