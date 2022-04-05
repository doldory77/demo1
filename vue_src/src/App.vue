<template>
  <div id="app">
    <div class="menu-container">
      <router-link class="menu" to="/user/join">회원가입</router-link><br />
      <router-link class="menu" to="/user/login">로그인</router-link><br />
    </div>
    <router-view></router-view>
    
    
    <toast ref="toast" :img-src="xxx"></toast>
  </div>
</template>

<script>
// import UserDetailView from "@/views/user/UserDetailView";
import lifeCycle from "@/mixins/lifeCycle";
import Toast from "./components/cmmn/Toast.vue";
export default {
  mixins: [lifeCycle],
  components: { Toast },
  methods: {
    showToast() {
      let msg = "Lorem ipsum dolor sit amet consectetur adipisicing elit. Assumend incidunt eligendi non reiciendis blanditiis?"
      this.$refs.toast.show(msg)
    }
  }
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
    &:nth-of-type(n+2) {
      border-left: none;
    }
  }
}
</style>
