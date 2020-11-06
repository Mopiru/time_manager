<template>
  <div id="comp-cont">
    <div class="title">Pointeuse Virtuelle</div>
    <div class="clock-butt">
      <button class="start-timer-butt timer-butt" :disabled="last_status" @click="clock">Start timer</button>
      <button class="stop-timer-butt timer-butt" :disabled="!last_status" @click="refresh">End timer</button>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import moment from "moment";

export default {
  data() {
    return {
      last_status: false,
      last_clock: null
    };
  },
  async mounted() {
    let userObj = JSON.parse(localStorage.user);
    let request = "http://127.0.0.1:4000/api/v1/clocks/"+userObj.userId;
    await axios.get(request)
    .then((response) => {
      this.last_status = response.data.data[response.data.data.length - 1].status;
    });

  },
  props: ["userId"],
  methods: {
    async clock() {
      this.last_status = !this.last_status;
      let userObj = JSON.parse(localStorage.user);
      let request = "http://127.0.0.1:4000/api/v1/clocks";
      let datetime = moment();
      let data = {
        clocks: {
          time: datetime.format(),
          status: true,
          user: userObj.userId
        },
      };
      this.last_clock = data
      const res = await axios.post(request, data);
      this.id_clock = res.data.id;
      // si rien data.data a test
    },
    async refresh() {
      this.last_status = !this.last_status;
      let request = "http://127.0.0.1:4000/api/v1/clocks";
      let userObj = JSON.parse(localStorage.user);
      let datetime = moment();
      let data = {
        clocks: {
          time: datetime.format(),
          status: false,
          user: userObj.userId
        }
      };
      const res = await axios.post(request, data);

      let workdata =  {"workingtimes": {
          "start": moment(this.last_clock.time).format(),
          "end": moment(data.clocks.time).format(),
          "user": userObj.userId
        }
      }
      await axios.post("http://127.0.0.1:4000/api/v1/workingtimes/", workdata)
      this.id_clock = res.data.id_clock;
    },
  },
};
</script>


<style scoped>
#comp-cont {
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  margin-bottom: 40px;
}

.title {
  font: 20px "montserrat";
  margin-bottom: 15px;
}

.timer-butt {
  height: 43px;
  padding: 0px 10px;
  border-radius: 40px;
  border: none;
  outline: none;
  cursor: pointer;
  box-shadow: 0px 0px 7px 7px rgba(255, 255, 255, 0.16);
  font: 16px "montserrat";
  cursor: pointer;
  background-color: white;
}

.timer-butt:disabled, .start-timer-butt:disabled:hover, .stop-timer-butt:disabled:hover {
  background-color: antiquewhite;  
}

.start-timer-butt:hover {
  background-color: seagreen;
}

.stop-timer-butt:hover {
  background-color: red;
}

.start-timer-butt {
  margin-right: 15px;
}
</style>