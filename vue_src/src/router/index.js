import Vue from "vue";
import VueRouter from "vue-router";
import UserJoin from "../views/user/UserDetailView";
import UserLogin from "../views/user/UserLoginView";

Vue.use(VueRouter);

const routes = [
  {
    path: "/user/join",
    name: "UserJoin",
    component: UserJoin,
  },
  {
    path: "/user/login",
    name: "UserLogin",
    component: UserLogin,
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

export default router;
