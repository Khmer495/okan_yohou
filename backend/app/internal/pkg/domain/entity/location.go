package entity

import "github.com/Khmer495/okan_yohou/internal/pkg/util/cerror"

type Location struct {
	lat float64
	lon float64
}

func NewLocation(lat float64, lon float64) (*Location, error) {
	if lat < 0 || 360 < lat {
		return nil, cerror.NewInvalidArgumentError("lat < 0 || 360 < lat", "緯度は0~360の間で指定してください。")
	}
	if lon < 0 || 180 < lon {
		return nil, cerror.NewInvalidArgumentError("lon < 0 || 180 < lon", "緯度は0~180の間で指定してください。")
	}
	location := Location{
		lat: lat,
		lon: lon,
	}
	return &location, nil
}
