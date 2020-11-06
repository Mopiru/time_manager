<template>
  <div class="container">
    <header class="jumbotron">
      <WorkingTime />
      <WorkingTimes/>
      <ClockManager/>
      <ChartManager/>
    </header>
  </div>
</template>

<script>
import UserService from '../services/user.service';
import WorkingTime from './WorkingTime.vue'
import WorkingTimes from './WorkingTimes.vue'
import ClockManager from './ClockManager.vue'
import ChartManager from './ChartManager.vue'

export default {
  name: 'User',
  components: {
    WorkingTime,
    WorkingTimes,
    ClockManager,
    ChartManager
  },
  data() {
    return {
      userId: ''
    };
  },
  mounted() {
    UserService.getUserBoard().then(
      response => {
        this.content = response.data;
      },
      error => {
        this.content =
          (error.response && error.response.data) ||
          error.message ||
          error.toString();
      }
    );
  }
};
</script>