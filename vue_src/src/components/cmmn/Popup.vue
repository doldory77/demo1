<template>
  <div :class="['pupup-container', on === 1 ? 'on' : 'off']">
    <div
      :class="['box', on === 1 ? 'animShow' : '']"
      :style="{ width: popupWidth + '%' }"
    >
      <div class="body">
        <h3 class="title">{{ title }}</h3>
        <div class="content">
          <p>{{ msg }}</p>
        </div>
      </div>
      <div class="toolbar">
        <button @click="confirm">확인</button>
      </div>
      <div class="close-btn" @click="close">X</div>
    </div>
  </div>
</template>
<script>
export default {
  props: {
    popupWidth: {
      type: Number,
      default: 50,
    },
  },
  data() {
    return {
      on: 0,
      title: "",
      msg: "Lorem ipsum dolor sit amet consectetur, adipisicing elit. Aut laudantium velit, vero repudiandae culpa quis ducimus iure repellat assumenda explicabo id non atque alias reprehenderit quibusdam. Impedit maxime qui similique!Lorem ipsum dolor sit amet consectetur, adipisicing elit. Aut laudantium velit, vero repudiandae culpa quis ducimus iure repellat assumenda explicabo id non atque alias reprehenderit quibusdam. Impedit maxime qui similique!Lorem ipsum dolor sit amet consectetur, adipisicing elit. Aut laudantium velit, vero repudiandae culpa quis ducimus iure repellat assumenda explicabo id non atque alias reprehenderit quibusdam. Impedit maxime qui similique!",
      callback: undefined,
    };
  },
  methods: {
    show(title, msg, callback) {
      this.title = title;
      this.msg = msg;
      this.callback = callback;
      this.on = 1;
    },
    close() {
      this.on = 0;
    },
    toggle() {
      if (this.on === 1) {
        this.on = 0;
      } else {
        this.on = 1;
      }
    },
    confirm(event) {
      if (this.callback) {
        this.callback(event.target.innerHTML + " 버튼 선택함!");
        this.close();
      }
    },
  },
};
</script>
<style lang="scss" scoped>
.pupup-container {
  position: fixed;
  display: flex;
  top: 0;
  left: 0;
  justify-content: center;
  align-items: center;
  width: 100vw;
  height: 100vh;
  background-color: rgba(0, 0, 0, 0.1);
  .box {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    position: relative;
    background-color: white;
    border-radius: 10px;
    box-shadow: 2px 2px 2px 1px rgba(0, 0, 0, 0.2);
    width: 50%;
    min-width: 280px;
    min-height: 200px;
    max-height: 480px;
    .body {
      flex-grow: 1;
      overflow: hidden;
      .title {
        text-align: center;
      }
      .content {
        width: 90%;
        max-height: 465px;
        background-color: #eee;
        padding: 4px;
        margin: 0 auto;
        overflow-y: auto;
      }
    }
    .toolbar {
      display: flex;
      justify-content: end;
      padding: 10px 10px;
    }
    .close-btn {
      display: inline-block;
      background-color: #eee;
      padding: 3px 8px;
      border-radius: 50%;
      border: 1px solid darkgray;
      position: absolute;
      top: 10px;
      right: 10px;
      cursor: pointer;
    }
  }
}
.on {
  display: flex;
}
.off {
  display: none;
}

@keyframes sizeUp {
  0% {
    opacity: 0;
    transform: scale(0.8);
  }
  100% {
    opacity: 1;
    transform: scale(1);
  }
}
.animShow {
  animation-name: sizeUp;
  animation-duration: 0.2s;
  animation-timing-function: ease-in-out;
  animation-fill-mode: forwards;
}
</style>
