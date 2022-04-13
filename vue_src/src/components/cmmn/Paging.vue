<template>
  <div class="paging-bar">
    <span
      v-if="pagingInfo.prevPageNo > 0"
      @click="search(pagingInfo.prevPageNo)"
      >&lt;</span
    >
    <span
      v-for="n in range"
      :key="n"
      @click="search(n)"
      :style="{ 'background-color': n == pagingInfo.currPageNo ? 'red' : '' }"
      >{{ n }}</span
    >
    <span
      v-if="pagingInfo.nextPageNo > 0"
      @click="search(pagingInfo.nextPageNo)"
      >&gt;</span
    >
  </div>
</template>
<script>
export default {
  data() {
    return {
      pagingInfo: {
        currPageNo: 1,
        prevPageNo: 0,
        blockStartPageNo: 0,
        blockEndPageNo: 0,
        nextPageNo: 0,
      },
    };
  },
  computed: {
    range() {
      let arr = [];
      if (this.pagingInfo.blockStartPageNo > 0) {
        for (
          let i = this.pagingInfo.blockStartPageNo,
            max = this.pagingInfo.blockEndPageNo;
          i <= max;
          i++
        ) {
          arr.push(i);
        }
      }
      return arr;
    },
  },
  methods: {
    setPaginInfo(pagingInfo) {
      Object.assign(this.pagingInfo, pagingInfo);
    },
    search(n) {
      this.$EventBus.$emit("search", n);
    },
  },
};
</script>
<style lang="scss" scoped>
.paging-bar {
  margin: 10px 0;
  display: flex;
  justify-content: center;
  align-items: center;
  span {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 48px;
    height: 48px;
    border: 1px solid #eee;
    cursor: pointer;
    &:hover {
      background-color: blanchedalmond;
    }
  }
}
</style>
