<template>
  <div class="container">
    <Navbar />
    <ChatWindow @connectCable="connectCable" :messages="messages" />
    <NewChatForm @connectCable="connectCable" />
  </div>
</template>

<script>
import Navbar from '../components/Navbar'
import ChatWindow from '../components/ChatWindow'
import NewChatForm from '../components/NewChatForm'

import axios from 'axios'
import ActionCable from 'actioncable'

import { formatDistanceToNow } from 'date-fns'
import { ja } from 'date-fns/locale'

export default {
  components: { Navbar, ChatWindow, NewChatForm},
  data() {
    return {
      messages: []
    }
  },

  computed: {
    formattedMessages() {
      if (!this.messages.length) {
        return []
      }
      return this.messages.map(message => {
        let time = formatDistanceToNow(new Date(message.created_at), {locale: ja})
        return { ...message, created_at: time }
      })
    }
  },

  methods: {
    async getMessages() {
      try {
        const res = await axios.get('http://localhost:3000/messages', {
          headers: {
            uid: window.localStorage.getItem('uid'),
            'access-token': window.localStorage.getItem('access-token'),
            client: window.localStorage.getItem('client')
          }
        })
        if (!res) {
          new Error('メッセージ一覧を取得できませんでした')
        }
        this.messages = res.data
      } catch (err) {
        console.log(err)
      }
    },

    connectCable(message) {
      this.messageChannel.perform('receive', {
        message: message,
        email: window.localStorage.getItem('uid')
      })
    }
  },

  // mountedはVue.jsの「ライフサイクルフック」の一つ
  // mountedの場合は、ページが読み込まれHTMLが表示される直前に実行されるメソッドです。
  mounted() {
    // ActionCable.createConsumer('ws://localhost:3000/cable')が、Ruby on RailsのAction Cableとコネクションを確立している部分
    const cable = ActionCable.createConsumer('ws://localhost:3000/cable')
    // cable.subscriptions.create('RoomChannel'の部分でRoomChannelという名前のチャンネルと常時接続状態にしています。チャンネルとは、LINEなどでいうルームのことだと考えてください。今回はルーム選択の機能はないため、RoomChannelという名前のチャネルのみ接続を行います。
    this.messageChannel = cable.subscriptions.create('RoomChannel', {
      // connectedはRoomChannelとのコネクションが確立したときに実行したいメソッドを記述します
      connected: () => {
        this.getMessages()
      },
      // receivedは、Ruby on RailsのAction Cableから何らかのデータが送られてきた時に実行するメソッドを記述します
      received: () => {
        this.getMessages()
      }
    })
  },

// beforeUnmountは、Vue3のライフサイクルフックの一つです。これは「インスタンスが削除される前」に実行されるメソッドです。「インスタンスが削除される前」と言われると難しく聞こえますが、「ページを移動したり、ブラウザを閉じる時」に実行されるメソッドだと考えてください。
  beforeUnmount () {
    this.messageChannel.unsubscribe()
  }
}
</script>

<style scoped>
</style>