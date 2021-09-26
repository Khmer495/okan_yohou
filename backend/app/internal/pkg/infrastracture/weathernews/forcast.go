package weathernews

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"time"

	"github.com/Khmer495/okan_yohou/internal/pkg/domain/entity"
	"github.com/Khmer495/okan_yohou/internal/pkg/util/cerror"
)

type srf struct {
	Date    time.Time `json:"date"`
	Wx      int       `json:"wx"`
	Temp    float64   `json:"temp"`
	Prec    int       `json:"prec"`
	Arpress float64   `json:"arpress"`
	Wndspd  float64   `json:"wndspd"`
	Wnddir  int       `json:"wnddir"`
	Rhum    int       `json:"rhum"`
	Feelidx int       `json:"feelidx"`
	Feeltmp float64   `json:"feeltmp"`
}

type mrf struct {
	Date    time.Time `json:"date"`
	Wx      int       `json:"wx"`
	Maxtemp float64   `json:"maxtemp"`
	Mintemp float64   `json:"mintemp"`
	Pop     int       `json:"pop"`
}

type apiError struct {
	Code    string `json:"code"`
	Message string `json:"message"`
}

type wxdata struct {
	Lat  float64 `json:"lat"`
	Lon  float64 `json:"lon"`
	Srfs []srf   `json:"srf"`
	Mrfs []mrf   `json:"mrf"`
}

type response struct {
	RequestId string     `json:"requestId"`
	Wxdata    []wxdata   `json:"wxdata"`
	Errors    []apiError `json:"error"`
}

func Forcast(lat entity.LatLon, lon entity.LatLon) (*response, error) {
	req, err := http.NewRequest("GET", apiEndpoint, nil)
	if err != nil {
		return nil, cerror.WrapInternalServerError(err, "http.NewRequest")
	}

	req.Header.Set("X-API-Key", apiKey)

	params := req.URL.Query()
	params.Add("lat", fmt.Sprint(lat.Float()))
	params.Add("lon", fmt.Sprint(lon.Float()))
	req.URL.RawQuery = params.Encode()

	client := http.Client{}

	res, err := client.Do(req)
	if err != nil {
		return nil, cerror.WrapInternalServerError(err, "client.Do")
	}
	defer res.Body.Close()

	resJsonBytes, err := ioutil.ReadAll(res.Body)
	if err != nil {
		return nil, cerror.WrapInternalServerError(err, "ioutil.ReadAll")
	}
	fmt.Println(string(resJsonBytes))

	response := response{}
	err = json.Unmarshal(resJsonBytes, &response)
	if err != nil {
		return nil, cerror.WrapInternalServerError(err, "json.Unmarshal")
	}

	return &response, nil
}
