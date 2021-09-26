package line

import (
	"github.com/Khmer495/okan_yohou/internal/pkg/util/cerror"
	"github.com/line/line-bot-sdk-go/v7/linebot"
	"go.uber.org/zap"
)

func PushMessage(message string) error {
	bot, err := linebot.New(channelSecret, channelToken)
	if err != nil {
		return cerror.WrapInternalServerError(err, "linebot.New")
	}

	_, err = bot.PushMessage(toUser, linebot.NewTextMessage(message)).Do()
	if err != nil {
		return cerror.WrapInternalServerError(err, "linebot.New")
	}

	zap.L().Info("通知を送信しました")
	return nil
}
