import Vue from "vue";
import "./plugins/axios";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import Toast from "@/components/cmmn/Toast";

Vue.config.productionTip = false;
Vue.component("toast", Toast);

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount("#app");
