. ./script/api/config
cp $OPENAPI_YAML_PATH $OPENAPI_PKG_PATH
oapi-codegen -generate "types" -package openapi $OPENAPI_YAML_PATH > $OPENAPI_PKG_PATH/types.gen.go
oapi-codegen -generate "server" -package openapi $OPENAPI_YAML_PATH > $OPENAPI_PKG_PATH/server.gen.go
oapi-codegen -generate "spec" -package openapi $OPENAPI_YAML_PATH > $OPENAPI_PKG_PATH/spec.gen.go
