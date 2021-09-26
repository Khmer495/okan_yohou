package entity

import "github.com/Khmer495/okan_yohou/internal/pkg/util/cerror"

type Wx struct {
	int
}

func NewWx(val int) (*Wx, error) {
	if val < 0 || 4 < val {
		return nil, cerror.NewInvalidArgumentError("val < 0 || 4 < val", "天気は1~4の間で指定してください。")
	}
	return &Wx{val}, nil
}

func (w *Wx) PInt() *int {
	if w == nil {
		return nil
	}
	return &w.int
}

func (w *Wx) IsTriggered(val int) bool {
	if w == nil {
		return true
	}
	switch w.int {
	case 1:
		return val == 100 || val == 500
	case 2:
		return val == 200 || val == 600
	case 3:
		return val == 300 || val == 650 || val == 850
	case 4:
		return val == 400 || val == 430 || val == 950
	default:
		return false
	}
}
