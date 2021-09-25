package entity

import "github.com/Khmer495/okan_yohou/internal/pkg/util/cerror"

type Trigger struct {
	wx      int
	temp    float64
	arpress int
	wndspd  int
	rhum    int
	feeltmp int
}

func NewTrigger(wx int, temp float64, arpress int, wndspd int, rhum int, feeltmp int) (*Trigger, error) {
	if wx < 0 || 5 < wx {
		return nil, cerror.NewInvalidArgumentError("wx < 0 || 5 < wx", "天気は1~5の間で指定してください。")
	}
	if arpress < 0 || 3 < arpress {
		return nil, cerror.NewInvalidArgumentError("arpress < 0 || 3 < arpress", "気圧は1~3の間で指定してください。")
	}
	if wndspd < 0 || 3 < wndspd {
		return nil, cerror.NewInvalidArgumentError("wndspd < 0 || 3 < wndspd", "風速は1~3の間で指定してください。")
	}
	if rhum < 0 || 3 < rhum {
		return nil, cerror.NewInvalidArgumentError("rhum < 0 || 3 < rhum", "湿度は1~3の間で指定してください。")
	}
	if feeltmp < 0 || 3 < feeltmp {
		return nil, cerror.NewInvalidArgumentError("feeltmp < 0 || 3 < feeltmp", "体感気温は1~3の間で指定してください。")
	}
	trigger := Trigger{
		wx:      wx,
		temp:    temp,
		arpress: arpress,
		wndspd:  wndspd,
		rhum:    rhum,
		feeltmp: feeltmp,
	}
	return &trigger, nil
}
