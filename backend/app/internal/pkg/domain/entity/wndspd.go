package entity

import "github.com/Khmer495/okan_yohou/internal/pkg/util/cerror"

type Wndspd struct {
	int
}

func NewWndspd(val int) (*Wndspd, error) {
	if val < 0 || 3 < val {
		return nil, cerror.NewInvalidArgumentError("val < 0 || 3 < val", "風速は1~3の間で指定してください。")
	}
	return &Wndspd{val}, nil
}

func (w *Wndspd) PInt() *int {
	if w == nil {
		return nil
	}
	return &w.int
}

func (w *Wndspd) IsTriggered(val float64) bool {
	if w == nil {
		return true
	}
	var th12 float64 = 3
	var th23 float64 = 5
	switch w.int {
	case 1:
		return val < th12
	case 2:
		return th12 <= val && val < th23
	case 3:
		return th23 < val
	default:
		return false
	}
}
