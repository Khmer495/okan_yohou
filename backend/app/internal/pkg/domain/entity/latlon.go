package entity

import (
	"math"

	"github.com/Khmer495/okan_yohou/internal/pkg/util/cerror"
)

type LatLon struct {
	float64
}

func NewLatLon(val float64) (*LatLon, error) {
	if val <= 0 {
		return nil, cerror.NewInvalidArgumentError("val < 0", "緯度経度は正の数を指定してください。")
	}
	val = math.Round(val*100) / 100
	return &LatLon{val}, nil
}

func (ll LatLon) Float() float64 {
	return ll.float64
}
