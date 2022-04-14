import Vue from "vue";
import "./plugins/axios";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import Toast from "@/components/cmmn/Toast";
import Loading from "@/components/cmmn/Loading";
import "./plugins/validator";

Vue.config.productionTip = false;

// 공통 이벤트(함수) 수신 및 송신 체널 생성
Vue.prototype.$EventBus = new Vue();
window.eventBus = Vue.prototype.$EventBus;

// 전역 컴포넌트 등록
Vue.component("toast", Toast);
Vue.component("loading", Loading);

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount("#app");
