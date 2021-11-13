import { createRouter, createWebHistory } from 'vue-router'

// 実際のルーティングを定義する箇所
const routes = []

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
