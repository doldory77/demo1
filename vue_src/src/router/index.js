import Vue from "vue";
import VueRouter from "vue-router";
import store from "../store";
import UserJoin from "../views/user/UserDetailView";
import UserLogin from "../views/user/UserLoginView";

Vue.use(VueRouter);

const routes = [
  {
    path: "/api/user/memberJoin",
    name: "UserJoin",
    component: UserJoin,
    meta: { authRequired: true },
  },
  {
    path: "/api/user/login",
    name: "UserLogin",
    component: UserLogin,
    meta: { authRequired: true },
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    // component: () =>
    //   import(/* webpackChunkName: "UserLogin" */ "../views/user/UserLoginView"),
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

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
        }
      },
    });
    // if (res.data.code === "000") {
    //   next();
    // }
  }
});

export default router;
