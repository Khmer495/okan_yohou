from linebot import LineBotApi
from linebot.models import TextSendMessage
from linebot.exceptions import LineBotApiError
import sys
import Settings

# print(Settings.CHANNEL_ACCESS_TOKEN)
CHANNEL_ACCESS_TOKEN = Settings.CHANNEL_ACCESS_TOKEN

args = sys.argv
#必要であるか分かりませんがコマンドライン引数を設定していなかったときの処理です
if len(args) == 1:
    args.append("メッセージ")
    print("LineBotに送信するためのSendMessage.pyのコマンドライン引数を設定してください")

line_bot_api = LineBotApi(CHANNEL_ACCESS_TOKEN)

try:
    line_bot_api.push_message('U7130974c3304a29d9044fec3472952b3', TextSendMessage(text=args[1]))
except LineBotApiError as e:
    print("エラーです")
