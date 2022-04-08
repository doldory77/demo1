<template>
  <div>
    <user-info ref="userInfo" :isDisabled="0" :isNew="1">
      <div class="toolbar right">
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
    test() {
      console.log(this.$refs.userInfo.getUserInfo);
    },
    joinUserWrap() {
      this.joinUser({ user: this.$refs.userInfo.getUserInfo });
    },
  },
};
</script>

<style lang="scss" scoped>

</style>
