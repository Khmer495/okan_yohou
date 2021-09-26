package entity

import (
	"golang.org/x/xerrors"
)

type Alert struct {
	id      Id
	title   string
	lat     LatLon
	lon     LatLon
	wx      *Wx
	temp    *Temp
	arpress *Arpress
	wndspd  *Wndspd
	rhum    *Rhum
	feeltmp *Feeltmp
	text    string
}

type Alerts []*Alert

func NewAlert(idString string, title string, latFloat float64, lonFloat float64, wxInt *int, tempFloat *float64, arpressInt *int, wndspdInt *int, rhumInt *int, feeltmpInt *int, text string) (*Alert, error) {
	id, err := NewId(idString)
	if err != nil {
		return nil, xerrors.Errorf("NewId: %w", err)
	}
	lat, err := NewLatLon(latFloat)
	if err != nil {
		return nil, xerrors.Errorf("NewLatLon: %w", err)
	}
	lon, err := NewLatLon(lonFloat)
	if err != nil {
		return nil, xerrors.Errorf("NewLatLon: %w", err)
	}
	var wx *Wx = nil
	if wxInt != nil {
		var err error
		wx, err = NewWx(*wxInt)
		if err != nil {
			return nil, xerrors.Errorf("NewWx: %w", err)
		}
	}
	var temp *Temp = nil
	if tempFloat != nil {
		var err error
		temp, err = NewTemp(*tempFloat)
		if err != nil {
			return nil, xerrors.Errorf("NewTemp: %w", err)
		}
	}
	var arpress *Arpress = nil
	if arpressInt != nil {
		var err error
		arpress, err = NewArpress(*arpressInt)
		if err != nil {
			return nil, xerrors.Errorf("NewArpress: %w", err)
		}
	}
	var wndspd *Wndspd = nil
	if wndspd != nil {
		var err error
		wndspd, err = NewWndspd(*wndspdInt)
		if err != nil {
			return nil, xerrors.Errorf("NewWndspd: %w", err)
		}
	}
	var rhum *Rhum = nil
	if rhumInt != nil {
		var err error
		rhum, err = NewRhum(*rhumInt)
		if err != nil {
			return nil, xerrors.Errorf("NewRhum: %w", err)
		}
	}
	var feeltmp *Feeltmp = nil
	if feeltmpInt != nil {
		var err error
		feeltmp, err = NewFeeltmp(*feeltmpInt)
		if err != nil {
			return nil, xerrors.Errorf("NewFeeltmp: %w", err)
		}
	}

	alert := Alert{
		id:      *id,
		title:   title,
		lat:     *lat,
		lon:     *lon,
		wx:      wx,
		temp:    temp,
		arpress: arpress,
		wndspd:  wndspd,
		rhum:    rhum,
		feeltmp: feeltmp,
		text:    text,
	}
	return &alert, nil
}

func InitAlert(title string, lat float64, lon float64, wx *int, temp *float64, arpress *int, wndspd *int, rhum *int, feeltmp *int, text string) (*Alert, error) {
	id, err := InitId()
	if err != nil {
		return nil, xerrors.Errorf("InitId: %w", err)
	}
	alert, err := NewAlert(id.Ulid().String(), title, lat, lon, wx, temp, arpress, wndspd, rhum, feeltmp, text)
	if err != nil {
		return nil, xerrors.Errorf("NewAlert: %w", err)
	}
	return alert, nil
}

func (a Alert) Id() Id {
	return a.id
}

func (a Alert) Title() string {
	return a.title
}

func (a *Alert) SetTitle(val string) error {
	a.title = val
	return nil
}

func (a Alert) Lat() LatLon {
	return a.lat
}

func (a *Alert) SetLat(val float64) error {
	lat, err := NewLatLon(val)
	if err != nil {
		return xerrors.Errorf("NewLatLon: %w", err)
	}
	a.lat = *lat
	return nil
}

func (a Alert) Lon() LatLon {
	return a.lon
}

func (a *Alert) SetLon(val float64) error {
	lon, err := NewLatLon(val)
	if err != nil {
		return xerrors.Errorf("NewLatLon: %w", err)
	}
	a.lon = *lon
	return nil
}

func (a Alert) PWx() *Wx {
	return a.wx
}

func (a *Alert) SetWx(val int) error {
	wx, err := NewWx(val)
	if err != nil {
		return xerrors.Errorf("NewWx: %w", err)
	}
	a.wx = wx
	return nil
}

func (a Alert) PTemp() *Temp {
	return a.temp
}

func (a *Alert) SetTemp(val float64) error {
	temp, err := NewTemp(val)
	if err != nil {
		return xerrors.Errorf("NewTemp: %w", err)
	}

	a.temp = temp
	return nil
}

func (a Alert) PArpress() *Arpress {
	return a.arpress
}

func (a *Alert) SetArpress(val int) error {
	arpress, err := NewArpress(val)
	if err != nil {
		return xerrors.Errorf("NewArpress: %w", err)
	}
	a.arpress = arpress
	return nil
}

func (a Alert) PWndspd() *Wndspd {
	return a.wndspd
}

func (a *Alert) SetWndspd(val int) error {
	wndspd, err := NewWndspd(val)
	if err != nil {
		return xerrors.Errorf("NewWndspd: %w", err)
	}
	a.wndspd = wndspd
	return nil
}

func (a Alert) PRhum() *Rhum {
	return a.rhum
}

func (a *Alert) SetRhum(val int) error {
	rhum, err := NewRhum(val)
	if err != nil {
		return xerrors.Errorf("NewRhum: %w", err)
	}
	a.rhum = rhum
	return nil
}

func (a Alert) PFeeltmp() *Feeltmp {
	return a.feeltmp
}

func (a *Alert) SetFeeltmp(val int) error {
	feeltmp, err := NewFeeltmp(val)
	if err != nil {
		return xerrors.Errorf("NewFeeltmp: %w", err)
	}
	a.feeltmp = feeltmp
	return nil
}

func (a Alert) Text() string {
	return a.text
}

func (a *Alert) SetText(val string) error {
	a.text = val
	return nil
}
