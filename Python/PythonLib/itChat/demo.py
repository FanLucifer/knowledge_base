# coding=utf8
import requests
import itchat

KEY = 'b9c41ce218eb4d718d2f7a5a531f6920'
TOCKEN = 'f5e0e30d4abfc3fb'


def get_response(msg):
    api_url = 'http://www.tuling123.com/openapi/api'
    data = {
        'key': KEY,  # 如果这个 apiKey 如不能用，那就注册一次
        'info': msg,  # 这是我们从好友接收到的消息 然后转发给图灵机器人
        'userid': 'wechat-robot',  # 这里你想改什么都可以
    }
    try:
        r = requests.post(api_url, data=data).json()
        return r.get('text')
    except Exception:
        return


@itchat.msg_register(itchat.content.TEXT)
def tuling_reply(msg):

    default_reply = 'I received: ' + msg['Text']
    reply = get_response(msg['Text'])
    return reply or default_reply


itchat.auto_login(hotReload=True)
itchat.run()
