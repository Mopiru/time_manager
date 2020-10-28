<template>
  <h1 class="main-title">Time Manager</h1>

  <div id="component-cont">
  <ClockManager/>
  <WorkingTime/>
  <WorkingTimes/>
  <User/>
  </div>

</template>

<script>
import WorkingTime from './components/WorkingTime.vue'
import WorkingTimes from './components/WorkingTimes.vue'
import ClockManager from './components/ClockManager.vue'
import User from './components/User.vue'

export default {
  name: 'App',
  components: {
    WorkingTime,
    WorkingTimes,
    ClockManager,
    User
  }
}
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,200;0,300;0,600;1,700&display=swap');

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif, Montserrat;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 20px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

#component-cont {
  align-self: center;
  width: 1366px;
  padding: 0px 54px;
}

.main-title {
  width: 100%;
  height: 70px;
  border-bottom: 1px solid #2c3e5019;
  box-sizing: border-box;
}
</style>
