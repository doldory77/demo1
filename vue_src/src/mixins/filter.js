export default {
  filters: {
    moneyPoint(value) {
      return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    },
    strUnit(value) {
      return `${value}원`;
    },
  },
};
