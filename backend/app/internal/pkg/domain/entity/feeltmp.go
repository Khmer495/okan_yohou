package entity

import "github.com/Khmer495/okan_yohou/internal/pkg/util/cerror"

type Feeltmp struct {
	int
}

func NewFeeltmp(val int) (*Feeltmp, error) {
	if val < 0 || 3 < val {
		return nil, cerror.NewInvalidArgumentError("val < 0 || 3 < val", "気圧は1~3の間で指定してください。")
	}
	return &Feeltmp{val}, nil
}

func (f *Feeltmp) PInt() *int {
	if f == nil {
		return nil
	}
	return &f.int
}

func (f *Feeltmp) IsTriggered(val float64) bool {
	if f == nil {
		return true
	}
	var th12 float64 = 20
	var th23 float64 = 30
	switch f.int {
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
