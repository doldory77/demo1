<template>
  <div class="box">
    <user-info ref="userInfo" :isDisabled="0" :isNew="1">
      <h3 slot="header" style="text-align: center">회원가입</h3>
      <div slot="footer" class="toolbar">
        <button @click="joinUserWrap">저장</button>
      </div>
    </user-info>
  </div>
</template>

<script>
import { createNamespacedHelpers } from "vuex";
import UserInfo from "../../components/user/UserInfo.vue";
const { mapGetters, mapMutations, mapActions } =
  createNamespacedHelpers("user");

export default {
  components: { UserInfo },
  computed: {
    ...mapGetters(["getUser"]),
  },
  methods: {
    ...mapMutations(["assignUser"]),
    ...mapActions(["joinUser"]),
    joinUserWrap() {
      this.joinUser({ user: this.$refs.userInfo.getUserInfo });
    },
  },
};
</script>

<style lang="scss" scoped>
  .box {
    width: 80%;
    margin: 0 auto;
  }
  .toolbar {
    display: flex;
    justify-content: end;
    padding: 10px 0;
    button {
      min-width: 100px;
    }
  }
</style>
