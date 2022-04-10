import Vue from "vue";
import VueRouter from "vue-router";
import store from "../store";
import Main from "../views/MainView";
import UserJoin from "../views/user/UserJoinView";
import UserLogin from "../views/user/UserLoginView";
import UserDetail from "../views/user/UserDetailView.vue";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "Main",
    component: Main,
    meta: { authRequired: false },
  },
  {
    path: "/api/user/memberJoin",
    name: "UserJoin",
    component: UserJoin,
    meta: { authRequired: false },
  },
  {
    path: "/api/user/login",
    name: "UserLogin",
    component: UserLogin,
    meta: { authRequired: false },
  },
  {
    path: "/api/user/myInfo",
    name: "UserDetail",
    component: UserDetail,
    meta: { authRequired: true },
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    // component: () =>
    //   import(/* webpackChunkName: "UserLogin" */ "../views/user/UserLoginView"),
  },
  {
    path: "*",
    name: "Main",
    component: Main,
    meta: { authRequired: false },
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});
window.router = router;
// 라우터 이동전 전처리 전역설정 - 로그인 필수 여부 체크
router.beforeEach((to, from, next) => {
  if (
    to.matched.some((routeInfo) => {
      return routeInfo.meta.authRequired;
    })
  ) {
    store.dispatch("user/menuCheck", {
      path: to.path,
      callback: (code) => {
        if (code === "0000") {
          next();
        } else {
          window.eventBus.$emit("showToast", "로그인 후 이용 가능합니다.");
        }
      },
    });
  } else {
    next();
  }
});

export default router;
