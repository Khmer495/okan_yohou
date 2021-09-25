package handler

import (
	"net/http"

	"github.com/labstack/echo/v4"
	"golang.org/x/xerrors"
)

func NewInvalidArgumentError(ctx echo.Context, msg string) error {
	return ctx.JSON(
		http.StatusBadRequest,
		"パラメータが不正です。"+msg,
	)
}

func NewInvalidRequestFormatError(ctx echo.Context, err error) error {
	eerr := &echo.HTTPError{}
	msg := "不正なリクエストの形式です。"
	if xerrors.As(err, &eerr) {
		msg += eerr.Internal.Error()
	}
	return ctx.JSON(
		http.StatusBadRequest,
		msg,
	)
}

func NewInternalServerError(ctx echo.Context) error {
	return ctx.JSON(
		http.StatusInternalServerError,
		"不明なエラーが発生しました。",
	)
}
