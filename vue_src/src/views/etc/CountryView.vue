<template>
  <div class="box">
    <div class="search-bar">
      <label class="item" for="countryNm">국가명:</label>
      <input class="item" id="countryNm" type="text" v-model="countryNm" />
      <button class="item" @click="search(1)">조회</button>
    </div>
    <table>
      <caption>
        국가정보
      </caption>
      <colgroup>
        <col width="25%" />
        <col width="25%" />
        <col width="25%" />
        <col width="25%" />
      </colgroup>
      <thead>
        <tr>
          <th>ISO CD</th>
          <th>약자(3)</th>
          <th>약자(2)</th>
          <th>국가명</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="country in countries" :key="country.isoCd">
          <td>{{ country.isoCd }}</td>
          <td>{{ country.initials1 }}</td>
          <td>{{ country.initials2 }}</td>
          <td>{{ country.countryNm }}</td>
        </tr>
      </tbody>
    </table>
    <paging ref="paging"></paging>
  </div>
</template>
<script>
import Paging from "../../components/cmmn/Paging.vue";
export default {
  components: { Paging },
  created() {
    this.$EventBus.$on("search", (n) => {
      this.search(n);
    });
  },
  data() {
    return {
      countryNm: "",
      countries: [],
    };
  },
  methods: {
    search(pageNo) {
      window
        .axios({
          method: "POST",
          url: "/api/etc/countryList.do?page=" + pageNo,
          data: { countryNm: this.countryNm },
        })
        .then((res) => {
          console.log(res);
          this.countries = res.data.output;
          this.$refs.paging.setPaginInfo(res.data.pagingInfo);
        })
        .catch((error) => {
          console.error(error);
        });
    },
  },
};
</script>
<style lang="scss" scoped>
.box {
  width: 80%;
  margin: 0 auto;
  .search-bar {
    display: flex;
    justify-content: flex-start;
    align-items: center;
    .item {
      min-width: 100px;
      &:nth-child(n + 2) {
        margin-left: 10px;
      }
      &:nth-child(2) {
        flex: 1 1 auto;
      }
    }
  }
  table {
    margin-top: 20px;
    width: 100%;
    border-collapse: collapse;
    border: 1px solid black;
    th,
    td {
      border: 1px solid black;
    }
  }
}
</style>
