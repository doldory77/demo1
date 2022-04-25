<template>
    <div>
        <button @click="send">send</button>
        <div></div>
    </div>
</template>

<script>
import SockJS from 'sockjs-client'
import Stomp from 'webstomp-client'
export default {
    created() {
        this.connect()
    },
    data() {
        return {
            stompClient: undefined
        }
    },
    methods: {
        connect() {
            let socket = new SockJS('http://localhost:8888/ws/hello')
            this.stompClient = Stomp.over(socket)
            this.stompClient.connect({}, frame => {
                this.stompClient.subscribe('/topic/greetings', greeting => {
                    alert(JSON.parse(greeting.body).content)
                })
            }, error => {
                console.log('소켓 연결 실패', error)
            })
        },
        send() {
            console.log('xxx')
        }
    }
}
</script>

<style lang="scss" scoped>

</style>