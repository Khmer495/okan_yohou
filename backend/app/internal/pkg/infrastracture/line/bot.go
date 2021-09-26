package line

import (
	"github.com/Khmer495/okan_yohou/internal/pkg/util/cerror"
	"github.com/line/line-bot-sdk-go/v7/linebot"
)

func PushMessage(message string) error {
	bot, err := linebot.New(channelSecret, channelToken)
	if err != nil {
		return cerror.WrapInternalServerError(err, "linebot.New")
	}

	_, err = bot.PushMessage("hoge", linebot.NewTextMessage(message)).Do()
	if err != nil {
		return cerror.WrapInternalServerError(err, "linebot.New")
	}
	return nil
}
