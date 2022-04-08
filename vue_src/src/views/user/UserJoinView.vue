<template>
  <div>
    <user-info>
      <div class="toolbar right">
        <button @click="addUser">저장</button>
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
  computed: {},
  methods: {
    ...mapActions(["fetchUsers", "addUser"]),
  },
};
</script>

<style lang="scss" scoped>
.container {
  width: 50%;
}
.toolbar {
  padding: 5px 0;
}
.right {
  text-align: right;
}
.flex-container {
  display: flex;
  flex-wrap: wrap;
  .item {
    flex: 1 1 40%;
    margin-top: 5px;
  }
}
</style>
