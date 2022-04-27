<template>
  <div>
    <h2>Mts Chart</h2>
    <button @click="send">send</button>
    <div></div>
  </div>
</template>

<script>
export default {
  props: ["ws"],
  created() {
    if (this.ws) {
      this.ws.onmessage = (e) => {
        console.log(e);
      };
    }
  },
  data() {
    return {};
  },
  methods: {
    send() {
      this.ws.send("doldory");
    },
  },
};
</script>

<style lang="scss" scoped></style>
