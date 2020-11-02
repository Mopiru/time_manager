<template>
<div class="comp-cont">
    <div>
      <ul v-for='workingtime in workingtimes' :key=workingtime.start>
        <li> #{{workingtime.id}} {{workingtime.start}} to {{workingtime.end}} </li>
      </ul>
    </div>
    <div>
      <button @click="getWorkingTimes"> Get WorkingTimes</button>
    </div>
</div>
</template>


<script>
import axios from "axios";
import moment from 'moment';

export default {
  data () { 
    return {
      workingtimes: []
    }
  },
  props: ['userId'],
  methods:{
    getWorkingTimes() {
      var request = "http://127.0.0.1:4000/api/workingTimes/:userID?".concat(this.userId)
      axios
      .get(request)
      .then((response) => (this.workingtimes = response.data.data));
      for (let i = 0; i < this.workingtimes.length; i++) {
        this.workingtimes.push({
          start: moment(String(this.workingtimes[i].start)).format('MM/DD/YYYY hh:mm'),
          end: moment(String(this.workingtimes[i].end)).format('MM/DD/YYYY hh:mm'),
          user: this.workingtimes[i].user
        })
      }
    }
  }
}
</script>