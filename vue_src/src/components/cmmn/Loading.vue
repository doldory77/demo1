<template>
  <div @click="toggle" class="loading-container" :style="{ display }">
    <img src="@/assets/img/Spinner-1s-200px.gif" />
  </div>
</template>

<script>
export default {
  data() {
    return {
      display: "none",
      isShow: false,
      // 참조 카운트
      refCount: 0,
    };
  },
  methods: {
    show() {
      this.refCount++;
      this.isShow = true;
      this.display = "flex";
    },
    off() {
      this.refCount--;
      // 참조 카운트 관리(중복 호출이 가능하여 참조 카운트가 0이하면 화면에서 삭제)
      if (this.refCount <= 0) {
        this.refCount = 0;
        this.isShow = false;
        this.display = "none";
      }
    },
    toggle() {
      if (this.isShow) {
        this.off();
      } else {
        this.show();
      }
    },
  },
};
</script>

<style lang="scss" scoped>
.loading-container {
  position: fixed;
  display: flex;
  top: 0;
  left: 0;
  justify-content: center;
  align-items: center;
  width: 100vw;
  height: 100vh;
  background-color: rgba(0, 0, 0, 0.1);
}
</style>
