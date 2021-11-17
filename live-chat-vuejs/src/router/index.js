import { createRouter, createWebHistory } from 'vue-router'
import Welcome from '../views/Welcome'
import Chatroom from '../views/Chatroom'

// toは次に表示されるページのルートです
// fromはtoのページにアクセスしようとしている元のページです
// nextはそのページにアクセスさせるか、他のページへリダイレクトさせるかなどを操作するためのメソッドです。
const requireAuth = async (to, from, next) => {
  console.log('requireAuthが呼ばれています')
  next()
}

// 実際のルーティングを定義する箇所
const routes = [
  {
    path: '/',
    name: 'Welcome',
    component: Welcome
  },
  {
    path: '/chatroom',
    name: 'Chatroom',
    component: Chatroom,
    // 設定されているルートにアクセスする前に実行されるメソッド
    beforeEnter: requireAuth
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
