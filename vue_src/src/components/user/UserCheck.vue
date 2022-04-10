<template>
  <div class="usercheck-container">
    <div class="box">
      <slot name="header"></slot>
      <div class="row">
        <label class="item text-label">아이디 :</label
        ><input class="item text-field" type="text" v-model="login.id" />
      </div>
      <div class="row">
        <label class="item text-label">비밀번호 :</label
        ><input
          class="item text-field"
          type="password"
          v-model="login.passwd"
        />
      </div>
    </div>
    <div class="toolbar right">
      <span class="item"
        ><input
          type="checkbox"
          :checked="login.sessionExtend"
          v-model="login.sessionExtend"
          id="sessionExtend"
        /><label for="sessionExtend">하루동안 자동로그인</label></span
      >
      <slot name="footer"></slot>
    </div>
  </div>
</template>

<script>
import { createNamespacedHelpers } from "vuex";
const { mapGetters, mapMutations } = createNamespacedHelpers("user");
export default {
  data() {
    return {
      login: {
        id: "",
        passwd: "",
        sessionExtend: false,
        isAutoExtendYn: "N",
      },
    };
  },
  computed: {
    ...mapGetters(["getUser"]),
    getLoginInfo() {
      let params = { isAutoExtendYn: "N" };
      if (this.login.sessionExtend) {
        params.isAutoExtendYn = "Y";
      } else {
        params.isAutoExtendYn = "N";
      }
      return { ...this.login, ...params };
    },
  },
  methods: {
    ...mapMutations(["setUserId", "setUserPasswd"]),
  },
};
</script>

<style lang="scss">
.usercheck-container {
  margin: 0 auto;
  width: 80%;
  .box {
    padding: 5px 0 20px 0;
    border-bottom: 1px solid #eee;
  }
  .row {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-around;
    padding: 3px 0;
    label {
      min-width: 200px;
      flex: 0 0 auto;
    }
    input {
      min-width: 200px;
      flex: 0 0 auto;
    }
  }
  .toolbar {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-around;
    .item {
      margin: 20px 0 0 0;
      min-width: 100px;
      flex: 0 0 auto;
    }
  }
}
</style>
