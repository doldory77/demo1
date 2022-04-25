<template>
    <div class="container">
        <div class="tab-header">
            <div class="tab-btn">호가</div>
            <div class="tab-btn">차트</div>
            <div class="tab-btn">일별가격</div>
            <div class="tab-btn">작품정보</div>
        </div>
        <br>
        <mts-1></mts-1>        
    </div>
</template>

<script>
import Mts1 from '../../components/mts/mts1.vue'
export default {
    components: { Mts1 }
}
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
    }
}
</style>