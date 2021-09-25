package usecase

import (
	"github.com/Khmer495/okan_yohou/internal/pkg/util/cerror"
)

func parseEntityConstractorError(err error, msg string) error {
	if cerror.IsCode(err, cerror.InvalidArgumentErrorCode) {
		return cerror.WrapInvalidArgumentError(err, msg, cerror.As(err).ClientMsg())
	}
	return cerror.WrapInternalServerError(err, msg)
}
