<template>
  <div class="box">
    <user-info ref="userInfo" :isDisabled="mode" :isNew="0">
      <h3 slot="header" style="text-align: center">나의정보</h3>
      <div slot="footer" class="toolbar">
        <button @click="modifyMode" :class="[isModify ? 'on' : 'off']">
          수정
        </button>
        <button @click="modifyModeCancel" :class="[isModify ? 'off' : 'on']">
          취소
        </button>
        <button @click="saveUserInfo" :class="[isModify ? 'off' : 'on']">
          저장
        </button>
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
  data() {
    return {
      mode: 1,
      isModify: true,
    };
  },
  components: { UserInfo },
  computed: {
    ...mapGetters(["getUser", "getUserIdntify"]),
  },
  methods: {
    ...mapMutations(["setUserId", "setUserPasswd"]),
    ...mapActions(["fetchUsers", "addUser"]),
    modifyMode() {
      this.mode = 0;
      this.isModify = false;
    },
    modifyModeCancel() {
      this.mode = 1;
      this.isModify = true;
    },
    saveUserInfo() {},
  },
};
</script>

<style lang="scss" scoped>
.box {
  width: 80%;
  margin: 0 auto;
  .toolbar {
    display: flex;
    flex-wrap: wrap;
    justify-content: flex-end;
    button {
      min-width: 100px;
      margin: 10px 0 0 5px;
    }
  }
}
.on {
  display: block;
}
.off {
  display: none;
}
</style>
