<template>
  <div id="app">
    <div class="menu-container">
      <router-link class="menu" to="/">HOME</router-link>
      <router-link class="menu" to="/api/user/memberJoin">회원가입</router-link>
      <router-link class="menu" to="/api/user/login">로그인</router-link>
      <router-link class="menu" to="/api/user/myInfo">나의정보</router-link>
    </div>
    <router-view></router-view>
    <loading ref="loading"></loading>
    <toast ref="toast"></toast>
    <popup ref="popup" :popupWidth="40"></popup>
  </div>
</template>

<script>
import lifeCycle from "@/mixins/lifeCycle";
import Popup from './components/cmmn/Popup.vue';

export default {
  components: { Popup },
  mixins: [lifeCycle],
  created() {
    // 부모객체에서 공통 수신함수 등록
    this.$EventBus.$on("showToast", (msg) => {
      this.showToast(msg);
    });
    this.$EventBus.$on("showLoading", () => {
      this.showLoading();
    });
    this.$EventBus.$on("showAlert", (title, msg, callback) => {
      this.showAlert(title, msg, callback);
    });
    // axios 요청과 응답 직전 공통 처리
    this.$axios.interceptors.request.use(
      (config) => {
        this.$refs.loading.show();
        return config;
      },
      (error) => {
        return Promise.reject(error);
      }
    );

    this.$axios.interceptors.response.use(
      (res) => {
        this.$refs.loading.off();
        if (res.data && res.data.code) {
          let code = Number(res.data.code)
          if (code === 1000) {
            this.$refs.toast.show(`[${res.data.code}] ${res.data.msg}`);
          }else if (code >= 9000 && code <= 9009) {
            this.$refs.popup.show("오류", `[${res.data.code}] ${res.data.msg}`, () => {this.$refs.popup.close();});  
          } else {
            this.$refs.toast.show(`[${res.data.code}] ${res.data.msg}`);
          } 
        }
        return res;
      },
      (error) => {
        return Promise.reject(error);
      }
    );
  },
  methods: {
    showToast(msg) {
      let msgTest =
        "Lorem ipsum dolor sit amet consectetur adipisicing elit. Assumend incidunt eligendi non reiciendis blanditiis?";
      this.$refs.toast.show(msg);
    },
    showLoading() {
      this.$refs.loading.show();
    },
    showAlert(title, msg, callback) {
      this.$refs.popup.show(title, msg, callback);
    },
  },
};
</script>

<style lang="scss" scoped>
@import "~@/style/cmmn";
.menu-container {
  display: flex;
  flex-wrap: wrap;
  margin-bottom: 10px;
  .menu {
    min-width: 100px;
    flex: 1 1 100px;
    background-color: #eee;
    text-align: center;
    text-decoration: none;
    padding: 5px;
    border-bottom: 1px solid darkgray;
  }
}
</style>
