<template>
    <div id="comp-cont">
        <div>
            <h1> Working Time</h1>
            <label> Start: <input type="text" placeholder="MM/DD/YYYY hh:mm" v-model="working_button.start"/> </label>
            <label> End: <input type="text" placeholder="MM/DD/YYYY hh:mm" v-model="working_button.end"/> </label>
            <label> Id: <input type="text" placeholder="#Id" v-model="working_button.id"/> </label>
        </div>
        <div>
            <button @click="createWorkingTime">Create</button>
            <button @click="deleteWorkingTime">Delete</button>
            <button @click="updateWorkingTime">Update</button>
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
            let request = "http://127.0.0.1:4000/api/workingTimes/:userID?".concat(this.userId)
            let data =  {"workingTimes": {
                    "start": moment(this.working_button.start, 'MM/DD/YYYY hh:mm').format(),
                    "end": moment(this.working_button.end, 'MM/DD/YYYY hh:mm').format(),
                    "user": this.userId
                }
            }
            const res = await axios.post(request, JSON.stringify(data));
            res.data.json;
        }
    },
    async updateWorkingTime() {
        let request = "http://127.0.0.1:4000/api/workingTimes/:userID?".concat(this.userId, "/:workingtimeID?", this.working_button.id)
        if (this.working_button.start != null && this.working_button.end != null && this.working_button.id >= 1) {
            let data =  { "workingTimes": {
                "start": moment(this.working_button.start, 'MM/DD/YYYY hh:mm').format(),
                "end": moment(this.working_button.end, 'MM/DD/YYYY hh:mm').format(),
                }
            }
            const res = await axios.put(request, JSON.stringify(data))
            res.data.json;
        } else if (this.working_button.start != null && this.working_button.end == null && this.working_button.id != null ) {
            let data =  { "workingTimes": {
                "start": moment(this.working_button.start, 'MM/DD/YYYY hh:mm').format(),
                "end": moment(this.working_button.end, 'MM/DD/YYYY hh:mm').format(),
                }
            }
            const res = await axios.put(request, JSON.stringify(data))
            res.data.json;
        } else if (this.working_button.start == null && this.working_button.end != null && this.working_button.id != null) {
            let data =  { "workingTimes": {
                "start": moment(this.working_button.start, 'MM/DD/YYYY hh:mm').format(),
                "end": moment(this.working_button.end, 'MM/DD/YYYY hh:mm').format(),
                }
            }
            const res = await axios.put(request, JSON.stringify(data))
            res.data.json;
        }
    },
    async deleteWorkingTime() {
        if (this.working_button.id >= 1) {
            let request = "http://127.0.0.1:4000/api/workingTimes/:userID?".concat(this.userId, "/:workingtimeID?", this.working_button.id)
            const res = await axios.delete(request, JSON.stringify(data))
            res.data.json;
        }
    }
  }
}
</script>