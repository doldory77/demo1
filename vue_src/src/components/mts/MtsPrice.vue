<template>
  <div class="grid">
    <div class="rows">
      <div class="row">
        <div class="cell right">
          <div
            class="grp up"
            :style="{ width: priceList[5]['remain_percent'] + '%' }"
          >
            <span>{{ priceList[5]["remain_amount"] | moneyPoint }}</span>
          </div>
        </div>
        <div class="cell-2 up">
          <span>{{ priceList[5]["price"] | moneyPoint }}</span
          ><span>{{ priceList[5]["rate_of_change"] }}</span>
        </div>
        <div class="cell"></div>
      </div>
      <div class="row">
        <div class="cell right">
          <div
            class="grp up"
            :style="{ width: priceList[4]['remain_percent'] + '%' }"
          >
            <span>{{ priceList[4]["remain_amount"] | moneyPoint }}</span>
          </div>
        </div>
        <div class="cell-2 up">
          <span>{{ priceList[4]["price"] | moneyPoint }}</span
          ><span>{{ priceList[4]["rate_of_change"] }}</span>
        </div>
        <div class="cell"></div>
      </div>
      <div class="row">
        <div class="cell right">
          <div
            class="grp up"
            :style="{ width: priceList[3]['remain_percent'] + '%' }"
          >
            <span>{{ priceList[3]["remain_amount"] | moneyPoint }}</span>
          </div>
        </div>
        <div class="cell-2 up">
          <span>{{ priceList[3]["price"] | moneyPoint }}</span
          ><span>{{ priceList[3]["rate_of_change"] }}</span>
        </div>
        <div class="cell"></div>
      </div>
      <div class="row">
        <div class="cell right">
          <div
            class="grp up"
            :style="{ width: priceList[2]['remain_percent'] + '%' }"
          >
            <span>{{ priceList[2]["remain_amount"] | moneyPoint }}</span>
          </div>
        </div>
        <div class="cell-2 up">
          <span>{{ priceList[2]["price"] | moneyPoint }}</span
          ><span>{{ priceList[2]["rate_of_change"] }}</span>
        </div>
        <div class="cell"></div>
      </div>
      <div class="row">
        <div class="cell right">
          <div
            class="grp up"
            :style="{ width: priceList[1]['remain_percent'] + '%' }"
          >
            <span>{{ priceList[1]["remain_amount"] | moneyPoint }}</span>
          </div>
        </div>
        <div class="cell-2 up">
          <span>{{ priceList[1]["price"] | moneyPoint }}</span
          ><span>{{ priceList[1]["rate_of_change"] }}</span>
        </div>
        <div class="cell"></div>
      </div>
      <div class="row">
        <div class="cell right">
          <div
            class="grp up"
            :style="{ width: priceList[0]['remain_percent'] + '%' }"
          >
            <span>{{ priceList[0]["remain_amount"] | moneyPoint }}</span>
          </div>
        </div>
        <div class="cell-2 up">
          <span>{{ priceList[0]["price"] | moneyPoint }}</span
          ><span>{{ priceList[0]["rate_of_change"] }}</span>
        </div>
        <div class="cell panel-pos">
          <div class="panel p-up">
            <div class="v1-cell" style="font-weight: 800">
              <span>시가총액</span><span>506,075억</span>
            </div>
            <div class="v2-cell">
              <span>시</span><span>60,600</span><span>0.17%</span>
            </div>
            <div class="v2-cell">
              <span style="color: red">고</span><span>61,800</span
              ><span>2.15%</span>
            </div>
            <div class="v2-cell">
              <span style="color: blue">저</span
              ><span style="color: blue !important">60,500</span
              ><span style="color: blue !important">0.00%</span>
            </div>
            <div class="v1-cell" style="font-weight: 800">
              <span>전일종가</span><span>60,100</span>
            </div>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="cell panel-pos">
          <div class="panel p-dw">
            <div class="viewTab">
              <div
                :class="{ on: viewMode === 1 }"
                class="viewTab-btn"
                @click="viewMode = 1"
              >
                체결
              </div>
              <div
                :class="{ on: viewMode === 2 }"
                class="viewTab-btn"
                @click="viewMode = 2"
              >
                차트
              </div>
            </div>
            <div class="view v1" v-if="viewMode === 1">
              <div class="v1-cell"><span>61,500</span><span>1</span></div>
              <div class="v1-cell"><span>61,500</span><span>3</span></div>
              <div class="v1-cell"><span>61,500</span><span>2</span></div>
              <div class="v1-cell"><span>61,500</span><span>1</span></div>
              <div class="v1-cell"><span>61,500</span><span>1</span></div>
            </div>
            <div class="view v2" v-if="viewMode === 2">차트화면</div>
          </div>
        </div>
        <div class="cell center dw">81,900</div>
        <div class="cell left">
          <div class="grp dw" style="width: 86%"><span>86%</span></div>
        </div>
      </div>
      <div class="row">
        <div class="cell"></div>
        <div class="cell center">81,800</div>
        <div class="cell left">
          <div class="grp dw" style="width: 62%"><span>62%</span></div>
        </div>
      </div>
      <div class="row">
        <div class="cell"></div>
        <div class="cell center">81,700</div>
        <div class="cell left">
          <div class="grp dw" style="width: 55%"><span>55%</span></div>
        </div>
      </div>
      <div class="row">
        <div class="cell"></div>
        <div class="cell center">81,600</div>
        <div class="cell left">
          <div class="grp dw" style="width: 37%"><span>37%</span></div>
        </div>
      </div>
      <div class="row">
        <div class="cell"></div>
        <div class="cell center">81,500</div>
        <div class="cell left">
          <div class="grp dw" style="width: 46%"><span>46%</span></div>
        </div>
      </div>
      <div class="row">
        <div class="cell"></div>
        <div class="cell center">81,400</div>
        <div class="cell left">
          <div class="grp dw" style="width: 23%"><span>23%</span></div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import filters from "@/mixins/filter.js";
export default {
  mixins: [filters],
  props: ["ws"],
  created() {
    if (this.ws) {
      this.ws.onmessage = (e) => {
        if (e && e.data) {
          this.priceList = JSON.parse(e.data);
        }
      };
    }
    this.send(1000);
  },
  destroyed() {
    this.doStop();
  },
  data() {
    return {
      viewMode: 1,
      stop: false,
      priceList: [
        {
          index: 1,
          price: 0,
          rate_of_change: "0",
          rate_type: 1,
          remain_amount: 0,
          remain_percent: 0,
          type: 1,
        },
        {
          index: 2,
          price: 0,
          rate_of_change: "0",
          rate_type: 1,
          remain_amount: 0,
          remain_percent: 0,
          type: 1,
        },
        {
          index: 3,
          price: 0,
          rate_of_change: "0",
          rate_type: 1,
          remain_amount: 0,
          remain_percent: 0,
          type: 1,
        },
        {
          index: 4,
          price: 0,
          rate_of_change: "0",
          rate_type: 1,
          remain_amount: 0,
          remain_percent: 0,
          type: 1,
        },
        {
          index: 5,
          price: 0,
          rate_of_change: "0",
          rate_type: 1,
          remain_amount: 0,
          remain_percent: 0,
          type: 1,
        },
        {
          index: 6,
          price: 0,
          rate_of_change: "0",
          rate_type: 1,
          remain_amount: 0,
          remain_percent: 0,
          type: 1,
        },
      ],
    };
  },
  methods: {
    send(delayedTime = 1000) {
      setTimeout(() => {
        if (this.ws.readyState === 1 && this.stop === false) {
          this.ws.send(
            JSON.stringify({
              cmd: "PRICE",
              header: { id: "1234" },
              body: { paramCnt: 1, param: "abcd" },
            })
          );
          this.send(delayedTime);
        }
      }, delayedTime);
    },
    doStop() {
      this.stop = true;
    }
  },
};
</script>

<style lang="scss" scoped>
.grid {
  width: 100%;
  height: 350px;
  border: 1px dotted darkgray;
  overflow-y: scroll;
  &::-webkit-scrollbar {
    display: none;
  }
}
.row {
  display: flex;
  justify-content: center;
  align-items: center;
  .cell {
    /* border: 1px dotted #e2e2e2; */
    flex-grow: 1;
    flex-shrink: 1;
    flex-basis: 100%;
    height: 42px;
    line-height: 42px;
  }
  .cell-2 {
    flex-grow: 1;
    flex-shrink: 1;
    flex-basis: 100%;
    display: flex;
    justify-content: space-around;
    align-items: center;
    font-weight: 800;
    color: red;
    height: 42px;
    span:last-child {
      font-size: 0.8rem;
    }
  }
}
.left {
  text-align: left;
}
.right {
  text-align: right;
}
.center {
  text-align: center;
}
.grp {
  display: inline-block;
  font-size: 0.8rem;
  span {
    padding: 0 5px;
  }
  transition: width 0.3s;
}
.up {
  background-color: rgba(173, 216, 230, 0.5);
}
.dw {
  background-color: rgba(255, 182, 193, 0.5);
}
.panel-pos {
  position: relative;
}
.panel {
  width: 100%;
  height: calc(5 * 42px);
  /* background-color: cornsilk; */
  position: absolute;
}
.p-up {
  left: 0;
  bottom: 0;
}
.p-dw {
  right: 0;
  top: 0;
}
.on {
  background-color: #eee;
}
.viewTab {
  display: flex;
  justify-content: space-around;
  align-items: center;
  padding: 8px;
  .viewTab-btn {
    display: inline-block;
    border: 1px solid #eee;
    cursor: pointer;
    padding: 4px 8px;
    line-height: 1rem;
    border-radius: 5px;
  }
}
@mixin v-cell {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 10px;
  height: 42px;
}
.v1-cell {
  @include v-cell;
  span {
    font-size: 0.8rem;
  }
  span:last-child {
    color: blue;
  }
}
.v2-cell {
  @include v-cell;
  span {
    font-size: 0.8rem;
  }
  span:first-child {
    border: 2px solid #eee;
    border-radius: 50%;
    width: 30px;
    height: 30px;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  span:nth-child(n + 2) {
    color: red;
  }
}
.v2 {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
}
</style>
