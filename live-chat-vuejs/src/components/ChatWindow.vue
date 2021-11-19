<template>
  <div class="chat-window">
    <div v-if="messages" class="messages">
      <ul v-for="message in messages" :key="message.id">
        <!-- データプロパティ内で定義したuidが、messageのemailと異なる場合、自分のメッセージではない（メッセージの受け取り側）と判断し、receivedというクラスを適用します。 -->
        <li
          :class="{
            received: message.email !== uid,
            sent: message.email === uid,
          }"
        >
          <span class="name">{{ message.name }}</span>
          <span class="message">{{ message.content }}</span>
          <span class="created-at">{{ message.created_at }}</span>
        </li>
      </ul>
    </div>
    {{ messages }}
  </div>
</template>

<script>
// 親コンポーネントからデータを受け取るにはprops
// 今回は親コンポーネントのChatroom.vueからmessagesを受け取る必要があるので、props: ['messages']と記述
export default {
  props: ["messages"],
};
</script>

<style scoped>
.chat-window {
  background: white;
  padding: 30px 20px;
  border-bottom: 1px solid #eee;
}

ul {
  list-style: none;
  margin: 0;
  padding: 0;
}
ul li {
  display: inline-block;
  clear: both;
}
.received .message {
  background: #eee;
  padding: 10px;
  display: inline-block;
  border-radius: 30px;
  margin-bottom: 2px;
  max-width: 400px;
}
.received {
  float: left;
}
.sent {
  float: right;
}
.sent .message {
  background: #677bb4;
  color: white;
  padding: 10px;
  display: inline-block;
  border-radius: 30px;
  margin-bottom: 2px;
  max-width: 400px;
}
.name {
  position: relative;
  margin-right: 6px;
  display: block;
  font-size: 13px;
}
.created-at {
  display: block;
  color: #999;
  font-size: 12px;
  margin-bottom: 20px;
  margin-left: 4px;
}
.messages {
  max-height: 400px;
  overflow: auto;
}
</style>