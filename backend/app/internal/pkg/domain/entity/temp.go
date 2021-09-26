package entity

type Temp struct {
	float64
}

func NewTemp(val float64) (*Temp, error) {
	return &Temp{val}, nil
}

func (t *Temp) PFloat64() *float64 {
	if t == nil {
		return nil
	}
	return &t.float64
}

func (t *Temp) IsTriggered(val float64) bool {
	if t == nil {
		return true
	}
	var th12 float64 = 20
	var th23 float64 = 30
	switch t.float64 {
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
