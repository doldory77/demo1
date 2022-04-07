<template>
  <div id="app">
    <div class="menu-container">
      <router-link class="menu" to="/api/user/memberJoin">회원가입</router-link
      ><br />
      <router-link class="menu" to="/api/user/login">로그인</router-link><br />
    </div>
    <router-view></router-view>
    <loading ref="loading"></loading>
    <toast ref="toast"></toast>
  </div>
</template>

<script>
// import UserDetailView from "@/views/user/UserDetailView";
import lifeCycle from "@/mixins/lifeCycle";

export default {
  mixins: [lifeCycle],
  created() {
    // 부모객체에서 공통 수신함수 등록
    this.$EventBus.$on("showLoading", () => {
      this.showLoading();
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
        return res;
      },
      (error) => {
        return Promise.reject(error);
      }
    );
  },
  components: {},
  methods: {
    showToast() {
      let msg =
        "Lorem ipsum dolor sit amet consectetur adipisicing elit. Assumend incidunt eligendi non reiciendis blanditiis?";
      this.$refs.toast.show(msg);
    },
    showLoading() {
      this.$refs.loading.show();
    },
  },
};
</script>

<style lang="scss" scoped>
@import "~@/style/cmmn";
.menu-container {
  display: flex;
  .menu {
    flex-basis: 100px;
    border: 1px solid black;
    text-align: center;
    text-decoration: none;
    padding: 3px;
    &:nth-of-type(n + 2) {
      border-left: none;
    }
  }
}
</style>
