<template>
  <div>
    <h1>로그인</h1>
    <user-check>
      <button @click="loginUser">확인</button>
    </user-check>
  </div>
</template>

<script>
import { createNamespacedHelpers } from "vuex";
const { mapGetters, mapActions } = createNamespacedHelpers("user");
import UserCheck from "@/components/user/UserCheck";
export default {
  components: { UserCheck },
  computed: {
    ...mapGetters(["getUserIdentify"]),
  },
  methods: {
    ...mapActions(["fetchUsers", "addUser", "loginUser"]),
    alarm() {
      alert(this.getUserIdentify);
    },
  },
};
</script>

<style lang="scss" scoped></style>
