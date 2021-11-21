<template>
  <form>
    <textarea
      placeholder="メッセージを入力してEnterを押してください"
      v-model="message"
      @keypress.enter.prevent="handleSubmit"
    ></textarea>
    <!-- .preventは、Enterキーを押すと画面がリロードしてしまうため、それを防ぐために追加しています。 -->
  </form>
</template>

<script>
export default {
  // 親コンポーネントのメソッドを実行することができる$emitメソッドは、第２引数でデータを渡すことができます。今回は入力されたメッセージを親コンポーネントのChatroom.vueに送りたいので、this.messageを渡しています。
  emits: ['connectCable'],
  data () {
    return {
      message: ''
    }
  },

  methods: {
    handleSubmit() {
      this.$emit('connectCable', this.message)
      this.message = ''
    }
  }
}
</script>

<style scoped>
  form {
    margin: 10px;
  }
  textarea {
    width: 100%;
    max-width: 100%;
    margin-bottom: 6px;
    padding: 10px;
    box-sizing: border-box;
    border: 0;
    border-radius: 20px;
    font-family: inherit;
    outline: none;
  }
</style>