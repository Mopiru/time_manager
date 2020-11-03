<template>
<div class="comp-cont">
  <div class="title">
    Affichez / Rafraichissez vos Working Times
  </div>
    <div>
      <ul v-for='workingtime in workingtimes' :key=workingtime.start>
        <li> #{{workingtime.id}} {{workingtime.start}} to {{workingtime.end}} </li>
      </ul>
    </div>
    <div class="butt-cont">
      <button class="get-butt" @click="getWorkingTimes"> Get WorkingTimes</button>
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
      var request = "http://127.0.0.1:4000/api/v1/workingTimes/:userID?".concat(this.userId)
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
  text-align: start;
}

.butt-cont {
  display: flex;
  justify-content: flex-start;
}

.get-butt {
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

.get-butt:hover {
  opacity: 0.7;
}

</style>