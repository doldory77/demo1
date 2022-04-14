<template>
  <div style="text-align: center">
    <h3>HOME : 메인 페이지</h3>
    <img @click="showAlert" src="@/assets/logo.png" />
    <form @submit.prevent="onSubmit">
      <input v-model="name" name="name" v-validate="'required|minLen3'" />
      <p v-if="$errors.has('name')">{{ $errors.first("name") }}</p>
      <button type="submit">submit</button>
    </form>
  </div>
</template>

<script>
export default {
  components: {},
  data() {
    return {
      name: "",
      errorBag: {},
    };
  },
  methods: {
    onSubmit() {
      this.$validator.validateAll();
    },
    showAlert() {
      this.$EventBus.$emit(
        "showAlert",
        "제목",
        "내용 : 하단 확인버튼을 클릭하면 파라미터로 전달한 함수가 실행됩니다. 알림대화상자 종료 후 함수 실행이 필요할 경우 적절하게 사용하시기 바랍니다.",
        (data) => {
          alert(data);
        }
      );
    },
  },
};
</script>

<style lang="scss" scoped>
img {
  cursor: pointer;
}
</style>
