<template>
  <div class="container">
    <div class="flex-container">
      <label class="item text-label">아이디 :</label
      ><input
        class="item text-field"
        type="text"
        :value="getUser.id"
        @input="setUserId"
      />
      <label class="item text-label">비밀번호 :</label
      ><input
        class="item text-field"
        type="password"
        :value="getUser.passwd"
        @input="setUserPasswd"
      />
    </div>
    <div class="toolbar right">
      <input type="checkbox" /> 자동로그인
      <slot></slot>
    </div>
  </div>
</template>

<script>
import { createNamespacedHelpers } from "vuex";
const { mapGetters, mapMutations } = createNamespacedHelpers("user");
export default {
  computed: {
    ...mapGetters(["getUser"]),
  },
  methods: {
    ...mapMutations(["setUserId", "setUserPasswd"]),
  },
};
</script>

<style lang="scss">
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
