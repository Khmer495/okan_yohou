package entity

import "github.com/Khmer495/okan_yohou/internal/pkg/util/cerror"

type Alert struct {
	id      Id
	title   string
	lat     float32
	lon     float32
	wx      *int
	temp    *float32
	arpress *int
	wndspd  *int
	rhum    *int
	feeltmp *int
	text    string
}

type Alerts []*Alert

func NewAlert(title string, lat float32, lon float32, wx *int, temp *float32, arpress *int, wndspd *int, rhum *int, feeltmp *int, text string) (*Alert, error) {
	if lat < 0 || 360 < lat {
		return nil, cerror.NewInvalidArgumentError("lat < 0 || 360 < lat", "緯度は0~360の間で指定してください。")
	}
	if lon < 0 || 180 < lon {
		return nil, cerror.NewInvalidArgumentError("lon < 0 || 180 < lon", "緯度は0~180の間で指定してください。")
	}
	if wx != nil {
		if *wx < 0 || 5 < *wx {
			return nil, cerror.NewInvalidArgumentError("*wx < 0 || 5 < *wx", "天気は1~5の間で指定してください。")
		}
	}
	if arpress != nil {
		if *arpress < 0 || 3 < *arpress {
			return nil, cerror.NewInvalidArgumentError("*arpress < 0 || 3 < *arpress", "気圧は1~3の間で指定してください。")
		}
	}
	if wndspd != nil {
		if *wndspd < 0 || 3 < *wndspd {
			return nil, cerror.NewInvalidArgumentError("*wndspd < 0 || 3 < *wndspd", "風速は1~3の間で指定してください。")
		}
	}
	if rhum != nil {
		if *rhum < 0 || 3 < *rhum {
			return nil, cerror.NewInvalidArgumentError("*rhum < 0 || 3 < *rhum", "湿度は1~3の間で指定してください。")
		}
	}
	if feeltmp != nil {
		if *feeltmp < 0 || 3 < *feeltmp {
			return nil, cerror.NewInvalidArgumentError("*feeltmp < 0 || 3 < *feeltmp", "体感気温は1~3の間で指定してください。")
		}
	}
	alert := Alert{
		title:   title,
		lat:     lat,
		lon:     lon,
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

func (a Alert) Id() Id {
	return a.id
}

func (a Alert) Title() string {
	return a.title
}

func (a *Alert) SetTitle(val string) {
	a.title = val
}

func (a Alert) Lat() float32 {
	return a.lat
}

func (a *Alert) SetLat(val float32) {
	a.lat = val
}

func (a Alert) Lon() float32 {
	return a.lon
}

func (a *Alert) SetLon(val float32) {
	a.lon = val
}

func (a Alert) PWx() *int {
	return a.wx
}

func (a *Alert) SetWx(val int) {
	a.wx = &val
}

func (a Alert) PTemp() *float32 {
	return a.temp
}

func (a *Alert) SetTemp(val float32) {
	a.temp = &val
}

func (a Alert) PArpress() *int {
	return a.arpress
}

func (a *Alert) SetArpress(val int) {
	a.arpress = &val
}

func (a Alert) PWndspd() *int {
	return a.wndspd
}

func (a *Alert) SetWndspd(val int) {
	a.wndspd = &val
}

func (a Alert) PRhum() *int {
	return a.rhum
}

func (a *Alert) SetRhum(val int) {
	a.rhum = &val
}

func (a Alert) PFeeltmp() *int {
	return a.feeltmp
}

func (a *Alert) SetFeeltmp(val int) {
	a.feeltmp = &val
}

func (a Alert) Text() string {
	return a.text
}

func (a *Alert) SetText(val string) {
	a.text = val
}
