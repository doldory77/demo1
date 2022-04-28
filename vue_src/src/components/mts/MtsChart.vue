<template>
  <div class="box">
    <apexcharts
      width="100%"
      height="350"
      type="candlestick"
      :options="chartOptions"
      :series="series"
    />
  </div>
</template>

<script>
export default {
  props: ["ws"],
  created() {
    if (this.ws) {
      this.ws.onmessage = (e) => {
        if (e && e.data) {
          console.log(e.data);
          // console.log(eval(e.data))
          this.series = eval(e.data);
        }
      };
      this.send(1000);
    }
  },
  destroyed() {
    this.doStop();
  },
  data() {
    return {
      stop: false,
      chartOptions: {
        title: {
          text: "CandleStick Chart",
          align: "left",
        },
        xaxis: {
          type: "datetime",
        },
        yaxis: {
          tooltip: {
            enabled: true,
          },
        },
        noData: {
          text: "Loading...",
        },
      },
      series: [
        // {
        //   data: [],
        // },
      ],
    };
  },
  methods: {
    send(delayedTime = 1000) {
      setTimeout(() => {
        if (this.ws.readyState === 1 && this.stop === false) {
          this.ws.send(
            JSON.stringify({
              cmd: "CHART",
              header: { id: "1234" },
              body: { paramCnt: 1, param: "abcd" },
            })
          );
          this.send(3000);
        }
      }, delayedTime);
    },
    doStop() {
      this.stop = true;
    },
  },
};
</script>

<style lang="scss" scoped></style>
