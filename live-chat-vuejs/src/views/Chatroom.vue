<template>
  <div class="container">
    <Navbar />
    <ChatWindow :messages="messages" />
    <NewChatForm />
  </div>
</template>

<script>
import Navbar from '../components/Navbar'
import ChatWindow from '../components/ChatWindow'
import NewChatForm from '../components/NewChatForm.vue'

import axios from 'axios'

export default {
  components: { Navbar, ChatWindow, NewChatForm},
  data() {
    return {
      message: []
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
        this.message = res.data
      } catch (err) {
        console.log(err)
      }
    },
  },

  // mountedはVue.jsの「ライフサイクルフック」の一つ
  // mountedの場合は、ページが読み込まれHTMLが表示される直前に実行されるメソッドです。
  mounted() {
    this.getMessages()
  }
}
</script>

<style scoped>
</style>