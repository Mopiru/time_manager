<template>
    <div id="comp-cont">
        <div class="title">Connectez vous pour utiliser le Time Manager</div>

        <div class="input-cont">
            <input placeholder="Username" v-model="user.username">
            <input placeholder="Email" v-model="user.email">
        </div>
    </div>
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
            let request = "http://127.0.0.1:4000/api/v1/users"
            let data =  {"users": {
                    "email": this.user.email,
                    "username": this.user.username
                }
            }
            await axios.get(request).then((res) => {
            res.data.json;
            })

    },
    async updateWorkingTime() {
        let request = "http://127.0.0.1:4000/api/v1/users/:userID?".concat(this.userId)
        let data =  {"users": {
                    "email": this.user.email,
                    "username": this.user.username
                }
            }
            await axios.get(request).then((res) => {
            res.data.json;
            })
    }
}
}
</script>

<style scoped>
#comp-cont {
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  font-family: "montserrat";
  margin-bottom: 40px;
}

.title {
  font: 20px "montserrat";
  margin-bottom: 15px;
}

input {
    height: 30px;
    width: 220px;
    font: 16px "montserrat";
    outline: none;
    border: 1px solid rgba(0, 0, 0, 1);
    border-radius: 5px;
    margin-right: 15px;
    padding-left: 10px;
}

input:hover {
    border-color: rgba(0, 0, 0, 0.5);
}
</style>