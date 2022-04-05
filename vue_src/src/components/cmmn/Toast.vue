<template>
  <div :class="['toast-container', {'anim': isAnim}]" :style="{display:toastDisplay}">
    <div class="toast-box">
      <img :style="{display:imgDisplay}" :src="imgSrc" alt="img" />
      <div class="toast-content">
        <p>{{ msg }}</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
    prop:[
        'imgSrc'
    ],
    data() {
        return {
            toastDisplay: 'none',
            isAnim: false,
            msg: ''
        }
    },
    methods: {
        show(msg) {
            this.msg = msg
            this.toastDisplay = 'flex'
            this.isAnim = true
            setTimeout(() => {
                this.isAnim = false
                this.toastDisplay = 'none'
            }, 4000)
        }
    },
    computed: {
        imgDisplay() {
            return this.imgSrc ? 'none' : 'none'
        }
    }
};
</script>

<style lang="scss" scoped>
@import "~@/style/cmmn";
.toast-container {
  position: fixed;
  width: 100vw;
  bottom: 0;
  display: flex;
  padding: 10px;
  justify-content: center;
  align-items: center;
  .toast-box {
    box-sizing: border-box;
    height: 80px;
    min-width: 30vw;
    max-width: 70vw;
    background-color: black;
    color: white;
    border-radius: 10px;
    padding: 10px;
    display: flex;
    box-shadow: 2px 2px 2px 1px rgba(0,0,0,0.2);
    .toast-content {
        p {
           white-space: nowrap;
        }
    }
  }
}
@keyframes fadeInOut {
    0% {
        opacity: 0;
        bottom: -100px;
    }
    20% {
        opacity: 1;
        bottom: 0px;
    }
    80% {
        opacity: 1;
        bottom: 0px;
    }
    100% {
        opacity: 0;
        bottom: -100px;
    }
}
.anim {
    animation-name: fadeInOut;
    animation-duration: 4s;
    animation-timing-function: ease-in-out;
    animation-fill-mode: forwards;
}
</style>
