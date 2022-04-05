<template>
  <div>
    <div>{{ "10000" | moneyPoint | strUnit }}</div>
    <span>{{ identify }}</span
    ><br />
    <button @click="updateName('루비')">updateName</button><br />
    <button @click="fetchUser({ callBack: callBack1 })">fetchUser</button><br />
  </div>
</template>

<script>
import cmmn from "@/mixins/cmmn.js";
import filter from "@/mixins/filter.js";
import { createNamespacedHelpers } from "vuex";
const { mapGetters, mapMutations, mapActions } =
  createNamespacedHelpers("user");

export default {
  mixins: [cmmn, filter],
  name: "test",
  computed: {
    ...mapGetters(["identify"]),
  },
  methods: {
    ...mapMutations(["updateName", "updateCellPhone"]),
    ...mapActions(["fetchUser"]),
    callBack1(value) {
      alert(value);
    },
  },
};
</script>

<style lang="scss">
@import "~@/style/cmmn";
</style>
