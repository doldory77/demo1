<template>
  <div class="userinfo-container">
    <slot name="header"></slot>
    <div>
      <div class="row">
        <label class="item text-label">아이디 :</label
        ><input
          class="item text-field"
          type="text"
          :disabled="isDisabled === 1"
          v-model="user.id"
        />
      </div>
      <div class="row">
        <label class="item text-label">비밀번호 :</label
        ><input
          class="item text-field"
          type="password"
          v-model="user.passwd"
          :disabled="isDisabled === 1"
        />
      </div>
      <div class="row">
        <label class="item text-label">이름 :</label
        ><input
          class="item text-field"
          type="text"
          :disabled="isDisabled === 1"
          v-model="user.name"
        />
      </div>
      <div class="row">
        <label class="item text-label">생년월일 :</label
        ><input
          class="item text-field"
          type="text"
          :disabled="isDisabled === 1"
          v-model="user.birthday"
        />
      </div>
      <div class="row">
        <label class="item text-label">핸드폰 번호 :</label
        ><input
          class="item text-field"
          type="text"
          :disabled="isDisabled === 1"
          v-model="user.cellPhoneNo"
        />
      </div>
      <div class="row">
        <label class="item text-label">Email :</label
        ><input
          class="item text-field"
          type="text"
          :disabled="isDisabled === 1"
          v-model="user.email"
        />
      </div>
    </div>
    <slot name="footer"></slot>
  </div>
</template>

<script>
import { createNamespacedHelpers } from "vuex";
const { mapGetters } = createNamespacedHelpers("user");

export default {
  data() {
    return {
      user: {
        id: "",
        passwd: "",
        userKindCd: "0004",
        name: "",
        birthday: "",
        cellPhoneNo: "",
        email: ""
      },
    };
  },
  created() {
    if (this.isNew === 0) {
      Object.assign(this.user, this.getUser);
    }
  },
  props: ["isDisabled", "isNew"],
  computed: {
    ...mapGetters(["getUser"]),
    getUserInfo() {
      return this.user;
    },
  },
};
</script>

<style lang="scss" scoped>
.userinfo-container {
  margin: 0 auto;
  .row {
    display: flex;
    flex-wrap: wrap;
    padding: 3px 0;
    label {
      min-width: 200px;
      flex: 0 0 auto;
    }
    input {
      min-width: 200px;
      flex: 1 0 auto;
    }
  }
}
</style>
