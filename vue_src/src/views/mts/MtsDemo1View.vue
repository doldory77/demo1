<template>
  <div class="container">
    <div class="tab-header">
      <div class="tab-btn" :class="{ on: tabNo === 1 }" @click="tabNo = 1">
        호가
      </div>
      <div class="tab-btn" :class="{ on: tabNo === 2 }" @click="tabNo = 2">
        차트
      </div>
      <div class="tab-btn" :class="{ on: tabNo === 3 }" @click="tabNo = 3">
        일별가격
      </div>
      <div class="tab-btn" :class="{ on: tabNo === 4 }" @click="tabNo = 4">
        작품정보
      </div>
    </div>
    <br />
    <mts-price v-if="tabNo === 1" :ws="websocket"></mts-price>
    <mts-chart v-if="tabNo === 2" :ws="websocket"></mts-chart>
    <mts-day-price v-if="tabNo === 3" :ws="websocket"></mts-day-price>
    <art-info v-if="tabNo === 4"></art-info>
  </div>
</template>

<script>
import MtsPrice from "@/components/mts/MtsPrice";
import MtsChart from "../../components/mts/MtsChart.vue";
import MtsDayPrice from "../../components/mts/MtsDayPrice.vue";
import ArtInfo from "../../components/mts/ArtInfo.vue";

export default {
  created() {
    this.websocket = new WebSocket("ws://localhost:8080/live");
    this.websocket.onopen = (e) => {
      console.log("open");
    };
    this.websocket.onclose = (e) => {
      console.log("close");
    };
  },
  destroyed() {
    if (this.websocket) this.websocket.close();
  },
  data() {
    return {
      websocket: undefined,
      tabNo: 1,
    };
  },
  methods: {},
  components: { MtsPrice, MtsChart, MtsDayPrice, ArtInfo },
};
</script>

<style lang="scss" scoped>
.container {
  width: 50%;
  margin: 0 auto;
}
.tab-header {
  display: flex;
  justify-content: center;
  align-items: center;
  .tab-btn {
    flex-grow: 1;
    flex-shrink: 1;
    flex-basis: 100%;
    text-align: center;
    border: 1px solid #eee;
    height: 36px;
    line-height: 36px;
    cursor: pointer;
  }
}
.on {
  background-color: #eee;
}
</style>
