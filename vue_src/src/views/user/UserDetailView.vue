<template>
  <div>
    <user-info :isDisabled="1" :isNew="0"></user-info>
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
    ...mapGetters(["getUser", "getUserIdntify"]),
  },
  methods: {
    ...mapMutations(["setUserId", "setUserPasswd"]),
    ...mapActions(["fetchUsers", "addUser"]),
    alarm() {
      alert(this.getUserIdntify);
    },
  },
};
</script>

<style lang="scss" scoped>

</style>
