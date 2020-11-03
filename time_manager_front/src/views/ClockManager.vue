<template>
  <div id="comp-cont">
    <div class="title">Pointeuse Virtuelle</div>
    <div class="clock-butt">
      <button class="start-timer-butt timer-butt" @click="clock">Start timer</button>
      <button class="stop-timer-butt timer-butt" @click="refresh">End timer</button>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import moment from "moment";

export default {
  data() {
    return {
      id_clock: 0,
    };
  },
  props: ["userId"],
  methods: {
    async clock() {
      let request = "http://127.0.0.1:4000/api/v1/clocks/:userID?".concat(
        this.userId
      );
      let datetime = moment();
      let data = {
        workingTimes: {
          time: datetime.format(),
          status: true,
          user: this.userId,
        },
      };
      const res = await axios.post(request, JSON.stringify(data));
      this.id_clock = res.data.id;
      // si rien data.data a test
    },
    async refresh() {
      let request = "http://127.0.0.1:4000/api/v1/clocks/:userID?".concat(
        this.userId
      );
      let datetime = moment();
      let data = {
        workingTimes: {
          time: datetime.format(),
          status: false,
          user: this.userId,
        },
      };
      const res = await axios.post(request, JSON.stringify(data));
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