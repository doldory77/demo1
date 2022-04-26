<template>
    <div>
        <button @click="connect">connect</button>
        <button @click="send">send</button>
        <button @click="close">close</button>
        <div></div>
    </div>
</template>

<script>
// import SockJS from 'sockjs-client'
// import Stomp from 'webstomp-client'
export default {
    created() {
        // this.connect()
    },
    data() {
        return {
            // stompClient: undefined
            websocket: undefined
        }
    },
    methods: {
        connect() {
            // let socket = new SockJS('http://localhost:8888/ws/hello')
            // this.stompClient = Stomp.over(socket)
            // this.stompClient.connect({}, frame => {
            //     this.stompClient.subscribe('/topic/greetings', greeting => {
            //         alert(JSON.parse(greeting.body).content)
            //     })
            // }, error => {
            //     console.log('소켓 연결 실패', error)
            // })
            this.websocket = new WebSocket('ws://localhost:8080/live');
            this.websocket.onopen = function(e) {
                console.log(e);
            }
            this.websocket.onclose = function(e) {
                console.log('close');
            }
            this.websocket.onmessage = function(e) {
                console.log(e)
            }
        },
        send() {
            this.websocket.send('doldory')
        },
        close() {
            // console.log('xxx')
            this.websocket.close();
        }
    }
}
</script>

<style lang="scss" scoped>

</style>