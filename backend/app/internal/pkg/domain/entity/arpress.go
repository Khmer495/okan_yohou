package entity

import "github.com/Khmer495/okan_yohou/internal/pkg/util/cerror"

type Arpress struct {
	int
}

func NewArpress(val int) (*Arpress, error) {
	if val < 0 || 3 < val {
		return nil, cerror.NewInvalidArgumentError("val < 0 || 3 < val", "気圧は1~3の間で指定してください。")
	}
	return &Arpress{val}, nil
}

func (a *Arpress) PInt() *int {
	if a == nil {
		return nil
	}
	return &a.int
}

func (a *Arpress) IsTriggered(val float64) bool {
	if a == nil {
		return true
	}
	var th12 float64 = 980
	var th23 float64 = 1020
	switch a.int {
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
