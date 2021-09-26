// Package openapi provides primitives to interact with the openapi HTTP API.
//
// Code generated by github.com/deepmap/oapi-codegen version v1.8.2 DO NOT EDIT.
package openapi

import (
	"bytes"
	"compress/gzip"
	"encoding/base64"
	"fmt"
	"net/url"
	"path"
	"strings"

	"github.com/getkin/kin-openapi/openapi3"
)

// Base64 encoded, gzipped, json marshaled Swagger object
var swaggerSpec = []string{

	"H4sIAAAAAAAC/+xXX2/bVBT/KtGFx5A4TbqmfiuZiiZE2cOEEKMiXnzTGPnP3fX11qiKlOuOUboO0KaR",
	"pUUKjC5rmbQWNFjWduzD3NglT/sK6F47TTM7pRvaC8tLcmLf8zt/fse/Ey+BkmUgy4QmsYG8BOxSBRqK",
	"MGd0iAk3ELYQxESD4rKCEYa2MFVol7CGiGaZQAb+bsP78YGcKGaKifcSvYd3gwuJ4oT4XV/3Op1EMct/",
	"dJ99G9z83ARJQKoIAhloJoELEINaEpQh1ImBojG6z27711r+bsPvbPcjvThohTGElQ2tEdCaylHhomIg",
	"nd+SMrNTn81OfVqYKBRyk3PnL5zNX/hodvaT3MzA3SZYMxe4t66QaFKHT3a8vTZIDlCzk6kzU2em8/ls",
	"EpQtbHAvoFrOJR0OUE3HuBTkpHOYCOofay+hZrLTqanJfD43PX0qWFxxjBianj739tqv1zwC40gJ6Die",
	"6YSUyp0qRQIXYxraq68ftu5717/yHj09DgsYXWV0h7krjF5/cUC7+6t+4z6jO72NLUbXes2bjP7CaJvR",
	"a8y9wY/VXc+9y9xb/hpldDNwZPQho40jkDiaiUZ4vONzMhyixegWozf9O01GVxhtj8C5aqo2UmMKvLfV",
	"q7dej4Ori1E8b3Pb32308fzm4xDP3/g6xOttbCWKucB6kihOBtavsTH46MDLjoahCuSL/InpdyR4AIKB",
	"Dcmbr/Hzmlm2omkJum4w93Z3b8X76bcjmLg7VyC2A69MSuJ1WgiaCtKADLIpKSWBJEAKqQjdSStcmoS5",
	"AMX8cIFSeNRzKpDBB5DMBCe4E1YMSCC2gXwxkuDyOls+YG7Hv7MLeBVABpcdiKsgCUzF4JkiZYHXHegi",
	"DxXt1suomSNYRl0+K+4qo4+6ndVe8/vRgXTN0MjJkeY5MTayTDuQ4glJ4l8lyyTQFH1QENK1kuhE+ks7",
	"kJUBoEagIRzfxbAMZPBOeiD+6VD504Hs147GQsFYqQLB8nCZH38oRsV2DEPBVd5N9x5b3uaVL690O/W/",
	"2w+8737w/mpwMGTZMUSdt+wBU3zmoE3et9TqK1X1v1pP4wUzXjBv24I5cbfUIpqXeSV1OIXURaWtgKFC",
	"oHqCvh0293trv4sD4TZKL4nvLzS1FvRPhwRGJe+suB6Invg8p4JIibkoA3NWohDWPDorb/Mbf+Ox0Nvh",
	"tScWDt+fg33TzxYcJ4NgB8asoP7A8Q2EnDghd0i0pLGcj+V8LOdvgZzHyrT05mX6xH+gfS2MVei0aRGt",
	"HKZziheJUNbmhrz+Y8nDQleyHHPkaDP3Vq9Ou89/5oNIW939P4P3iDgm/rVJ4dMy+Gv+hlaFiArxlT6w",
	"g3UggwohSE6ndauk6BXLJnJeykugNl/7JwAA///VOEwvihIAAA==",
}

// GetSwagger returns the content of the embedded swagger specification file
// or error if failed to decode
func decodeSpec() ([]byte, error) {
	zipped, err := base64.StdEncoding.DecodeString(strings.Join(swaggerSpec, ""))
	if err != nil {
		return nil, fmt.Errorf("error base64 decoding spec: %s", err)
	}
	zr, err := gzip.NewReader(bytes.NewReader(zipped))
	if err != nil {
		return nil, fmt.Errorf("error decompressing spec: %s", err)
	}
	var buf bytes.Buffer
	_, err = buf.ReadFrom(zr)
	if err != nil {
		return nil, fmt.Errorf("error decompressing spec: %s", err)
	}

	return buf.Bytes(), nil
}

var rawSpec = decodeSpecCached()

// a naive cached of a decoded swagger spec
func decodeSpecCached() func() ([]byte, error) {
	data, err := decodeSpec()
	return func() ([]byte, error) {
		return data, err
	}
}

// Constructs a synthetic filesystem for resolving external references when loading openapi specifications.
func PathToRawSpec(pathToFile string) map[string]func() ([]byte, error) {
	var res = make(map[string]func() ([]byte, error))
	if len(pathToFile) > 0 {
		res[pathToFile] = rawSpec
	}

	return res
}

// GetSwagger returns the Swagger specification corresponding to the generated code
// in this file. The external references of Swagger specification are resolved.
// The logic of resolving external references is tightly connected to "import-mapping" feature.
// Externally referenced files must be embedded in the corresponding golang packages.
// Urls can be supported but this task was out of the scope.
func GetSwagger() (swagger *openapi3.T, err error) {
	var resolvePath = PathToRawSpec("")

	loader := openapi3.NewLoader()
	loader.IsExternalRefsAllowed = true
	loader.ReadFromURIFunc = func(loader *openapi3.Loader, url *url.URL) ([]byte, error) {
		var pathToFile = url.String()
		pathToFile = path.Clean(pathToFile)
		getSpec, ok := resolvePath[pathToFile]
		if !ok {
			err1 := fmt.Errorf("path not found: %s", pathToFile)
			return nil, err1
		}
		return getSpec()
	}
	var specData []byte
	specData, err = rawSpec()
	if err != nil {
		return
	}
	swagger, err = loader.LoadFromData(specData)
	if err != nil {
		return
	}
	return
}

