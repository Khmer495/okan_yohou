//go:generate mockgen -source=$GOFILE -destination=mock_$GOFILE -package=$GOPACKAGE
package repository

import (
	"context"
	"fmt"

	"github.com/Khmer495/okan_yohou/internal/pkg/config"
	"github.com/Khmer495/okan_yohou/internal/pkg/ent"
	"go.uber.org/zap"
)

var MysqlClient *ent.Client

func NewMysqlClient() {
	var err error
	MysqlClient, err = ent.Open("mysql", fmt.Sprintf("%s?parseTime=True", config.MysqlDSN()), ent.Debug())
	if err != nil {
		zap.S().Panicf("ent.Open: %+v", err)
	}
	if err := MysqlClient.Schema.Create(context.Background()); err != nil {
		zap.S().Panicf("mysqlClient.Schema.Create: %+v", err)
	}
}
