class RoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "room_channel"
    # どのチャンネルとコネクションを確立するかをstream_fromで指定
    # チャネルとはチャットルームのようなもの 
  end

  # ユーザーがメッセージを送信し、そのメッセージが受信される度に呼び出されるメソッド
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    # コネクション切断時に呼び出されるメソッドはここで定義
  end

  def receive(data)
    user = User.find_by(email: data['email'])

    if message = Message.create(content: data['message'], user_id: user.id)
      #  ActionCable.server.broadcastはこのroom_channelチャネルに接続しているWebブラウザ全てにデータを送信するメソッド
      ActionCable.server.broadcast 'room_channel', { message: data['message'], name: user.name, created_at: message.created_at }
    end
  end

  # 以下のようなオブジェクトデータが送信されてくる
  # data = {
  #   'message': 'こんにちは！',
  #   'email': 'momoko@test.com'
  # }
end
