<template>
  <div class="chat-window">
    {{ messages }}
  </div>
</template>

<script>
// 親コンポーネントからデータを受け取るにはprops
// 今回は親コンポーネントのChatroom.vueからmessagesを受け取る必要があるので、props: ['messages']と記述
export default {
  props: ['messages'],
}
</script>

<style scoped>
  .chat-window {
    background: white;
    padding: 30px 20px;
    border-bottom: 1px solid #eee;
  }
</style>