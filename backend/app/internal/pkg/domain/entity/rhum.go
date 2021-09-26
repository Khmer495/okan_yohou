package entity

import "github.com/Khmer495/okan_yohou/internal/pkg/util/cerror"

type Rhum struct {
	int
}

func NewRhum(val int) (*Rhum, error) {
	if val < 0 || 3 < val {
		return nil, cerror.NewInvalidArgumentError("val < 0 || 3 < val", "湿度は1~3の間で指定してください。")
	}
	return &Rhum{val}, nil
}

func (r *Rhum) PInt() *int {
	if r == nil {
		return nil
	}
	return &r.int
}

func (r *Rhum) IsTriggered(val int) bool {
	if r == nil {
		return true
	}
	var th12 int = 30
	var th23 int = 60
	switch r.int {
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
