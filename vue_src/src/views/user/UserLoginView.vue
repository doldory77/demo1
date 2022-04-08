<template>
  <div>
    <user-check ref="userCheck">
      <h3 slot="header" style="text-align:center;">로그인</h3>
      <button slot="footer" class="item" @click="loginUserWrap">확인</button>
    </user-check>
  </div>
</template>

<script>
import { createNamespacedHelpers } from "vuex";
const { mapGetters, mapActions } = createNamespacedHelpers("user");
import UserCheck from "@/components/user/UserCheck";
export default {
  components: { UserCheck },
  methods: {
    ...mapActions(["loginUser"]),
    loginUserWrap() {
      this.loginUser(this.$refs.userCheck.getLoginInfo);
    },
  },
};
</script>

<style lang="scss" scoped></style>
