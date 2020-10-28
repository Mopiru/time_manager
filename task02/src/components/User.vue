<template>
    <input v-model="user.username">
    <input v-model="user.email">
</template>

<script>
import axios from "axios";
import moment from 'moment';

export default {
  data () { 
    return {
        user: {
            username:"",
            email: ""
        },
        users: []
    }
  },
  props: ['userId'],
  methods:{
    async getUsers() {
            let request = "http://127.0.0.1:4000/api/users"
            let data =  {"users": {
                    "email": this.user.email,
                    "username": this.user.username
                }
            }
            const res = await axios.get(request);
            res.data.json;
    },
    async updateWorkingTime() {
        let request = "http://127.0.0.1:4000/api/users/:userID?".concat(this.userId)
        let data =  {"users": {
                    "email": this.user.email,
                    "username": this.user.username
                }
            }
            const res = await axios.get(request);
            res.data.json;
    }
}
}
</script>