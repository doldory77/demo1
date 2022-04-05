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
      <label class="item text-label">이름 :</label
      ><input class="item text-field" type="text" :value="getUser.name" />
      <label class="item text-label">생년월일 :</label
      ><input class="item text-field" type="text" :value="getUser.birthday" />
      <label class="item text-label">핸드폰 번호 :</label
      ><input
        class="item text-field"
        type="text"
        :value="getUser.cellPhoneNo"
      />
    </div>
    <div class="toolbar right">
      <button @click="addUser">저장</button>
    </div>
  </div>
</template>

<script>
import { createNamespacedHelpers } from "vuex";
const { mapGetters, mapMutations, mapActions } =
  createNamespacedHelpers("user");

export default {
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
