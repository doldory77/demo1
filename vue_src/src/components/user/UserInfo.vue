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
          name="user.id"
          v-validate="'required|alphaNum'"
        />
      </div>
      <div class="row">
        <label class="item text-label">비밀번호 :</label
        ><input
          class="item text-field"
          type="password"
          v-model="user.passwd"
          :disabled="isDisabled === 1"
          name="user.passwd"
          v-validate="'required|passwd2'"
        />
      </div>
      <div class="row">
        <label class="item text-label">이름 :</label
        ><input
          class="item text-field"
          type="text"
          :disabled="isDisabled === 1"
          v-model="user.name"
          name="user.name"
          v-validate="'required|hangul|min2'"
        />
      </div>
      <div class="row">
        <label class="item text-label">생년월일 :</label
        ><input
          class="item text-field"
          type="text"
          :disabled="isDisabled === 1"
          v-model="user.birthday"
          name="user.birthday"
          v-validate="'yyyymmdd'"
        />
      </div>
      <div class="row">
        <label class="item text-label">핸드폰 번호 :</label
        ><input
          class="item text-field"
          type="text"
          :disabled="isDisabled === 1"
          v-model="user.cellPhoneNo"
          name="user.cellPhoneNo"
          v-validate="'cellphone1'"
        />
      </div>
      <div class="row">
        <label class="item text-label">Email :</label
        ><input
          class="item text-field"
          type="text"
          :disabled="isDisabled === 1"
          v-model="user.email"
          name="user.email"
          v-validate="'email'"
        />
      </div>
    </div>
    <slot name="footer"></slot>
    <p class="input-err" v-if="$errors.has('user.id')">
      {{ $errors.first("user.id") }}
    </p>
    <p class="input-err" v-if="$errors.has('user.passwd')">
      {{ $errors.first("user.passwd") }}
    </p>
    <p class="input-err" v-if="$errors.has('user.name')">
      {{ $errors.first("user.name") }}
    </p>
    <p class="input-err" v-if="$errors.has('user.birthday')">
      {{ $errors.first("user.birthday") }}
    </p>
    <p class="input-err" v-if="$errors.has('user.cellPhoneNo')">
      {{ $errors.first("user.cellPhoneNo") }}
    </p>
    <p class="input-err" v-if="$errors.has('user.email')">
      {{ $errors.first("user.email") }}
    </p>
  </div>
</template>

<script>
import { createNamespacedHelpers } from "vuex";
const { mapGetters } = createNamespacedHelpers("user");

export default {
  name: "UserInfo",
  data() {
    return {
      user: {
        id: "",
        passwd: "",
        userKindCd: "0004",
        name: "",
        birthday: "",
        cellPhoneNo: "",
        email: "",
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
  methods: {
    validate(callback) {
      if (this.$validator.validateAll()) {
        if (callback) callback();
      }
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
.input-err {
  color: red;
}
</style>
