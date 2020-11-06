<template>
    <div id="comp-cont">
        <div id="text-input-cont">
            <div class="title"> Working Time</div>
            <div class="info-text">Gérez vos working times: </div>

            <label> Start: <input type="text" placeholder="MM/DD/YYYY hh:mm" v-model="working_button.start"/> </label>
            <label> End: <input type="text" placeholder="MM/DD/YYYY hh:mm" v-model="working_button.end"/> </label>
            <label> Id: <input type="text" placeholder="#Id" v-model="working_button.id"/> </label>
        </div>
        <div>
            <button class="button-work" @click="createWorkingTime">Create</button>
            <button class="button-work" @click="deleteWorkingTime">Delete</button>
            <button class="button-work" @click="updateWorkingTime">Update</button>
        </div>
    </div>
</template>

<script>
import axios from "axios";
import moment from 'moment';

export default {
  data() { 
    return {
        working_button: {
            start:"",
            end: "",
            id: 0
        },
        workingtimes: []
    }
  },
  props: ['userId'],
  methods:{
    async createWorkingTime() {
        if (this.working_button.start != null && this.working_button.end != null) {
            let request = "http://127.0.0.1:4000/api/v1/workingtimes/";

            let data =  {"workingtimes": {
                    "start": moment(this.working_button.start, 'MM/DD/YYYY hh:mm').format(),
                    "end": moment(this.working_button.end, 'MM/DD/YYYY hh:mm').format(),
                    "user": this.working_button.id
                }
            }
            console.log(data);
            const res = await axios.post(request,data);
            res.data.json;
        }
    },
    async updateWorkingTime() {
        let userObj = JSON.parse(localStorage.user);
        let request = "http://127.0.0.1:4000/api/v1/workingtimes/"+userObj.userId+"/"+this.working_button.id;
        if (this.working_button.start != null && this.working_button.end != null && this.working_button.id >= 1) {
            let data =  { "workingimes": {
                "start": moment(this.working_button.start, 'MM/DD/YYYY hh:mm').format(),
                "end": moment(this.working_button.end, 'MM/DD/YYYY hh:mm').format(),
                }
            }
            const res = await axios.put(request, data)
            res.data.json;
        } else if (this.working_button.start != null && this.working_button.end == null && this.working_button.id != null ) {
            let data =  { "workingimes": {
                "start": moment(this.working_button.start, 'MM/DD/YYYY hh:mm').format(),
                "end": moment(this.working_button.end, 'MM/DD/YYYY hh:mm').format(),
                }
            }
            const res = await axios.put(request, data)
            res.data.json;
        } else if (this.working_button.start == null && this.working_button.end != null && this.working_button.id != null) {
            let data =  { "workingimes": {
                "start": moment(this.working_button.start, 'MM/DD/YYYY hh:mm').format(),
                "end": moment(this.working_button.end, 'MM/DD/YYYY hh:mm').format(),
                }
            }
            const res = await axios.put(request, data)
            res.data.json;
        }
    },
    async deleteWorkingTime() {
        if (this.working_button.id >= 1) {
            let request = "http://127.0.0.1:4000/api/v1/workingtimes/"+this.working_button.id;
            const res = await axios.delete(request)
            res.data.json;
        }
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

#text-input-cont {
    margin-bottom: 15px;
}

.title {
  font: 20px "montserrat";
  margin-bottom: 15px;
  text-align: start;
}

.info-text {
    font: 16px "montserrat";
    margin-bottom: 15px;
    text-align: start;
}

.button-work {
    height: 43px;
    padding: 0px 20px;
    border-radius: 40px;
    border: none;
    outline: none;
    cursor: pointer;
    box-shadow: 0px 0px 7px 7px rgba(255, 255, 255, 0.16);
    font: 16px "montserrat";
    cursor: pointer;
    margin-right: 15px;
}

input {
    height: 30px;
    width: 220px;
    font: 16px "montserrat";
    outline: none;
    border: 1px solid rgba(0, 0, 0, 1);
    border-radius: 5px;
    padding-left: 10px;
}

input:hover {
    border-color: rgba(0, 0, 0, 0.5);
}

.button-work:hover {
  opacity: 0.7;
}



</style>