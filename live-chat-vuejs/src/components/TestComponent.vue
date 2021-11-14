<template>
  <div>
    コンポーネントから表示されています。
    <p>{{ message }}</p>
    <button @click="onClick">親メソッドを実行するボタン</button>
  </div>
</template>

<script>
export default {
  props: ['message', 'isEnabled'],

  methods: {
    //emitを利用することで親コンポーネントのメソッドを実行できる
    onClick() {
      this.$emit("toggle")
    }
  }
}
</script>