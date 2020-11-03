<template>
 <div>
   <form class="login" @submit.prevent="login">
     <h1>Sign in</h1>
     <label>User name</label>
     <input required v-model="user.username" type="text" placeholder="Username"/>
     <label>User email</label>
     <input required v-model="user.email" type="text" placeholder="email"/>
     <label>Password</label>
     <input required v-model="user.password" type="password" placeholder="Password"/>
     <hr/>
     <button @click="connectionUser">login</button>
     <button @click="createUser">Sign in</button>
   </form>
 </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      user: {
        username: "",
        email: "",
        password: ""
      },
      error: []
    }
  },
  connectionUser() {
    let request = {
      "users": {
        "username": user.username,
        "email": user.email,
        "password": user.password
      }
    }
    axios.get('http://127.0.0.1:4000/api/users', JSON.stringify(request))
    .then(response => {})
    .catch(e => {
      this.errors.push(e)
    })
  },
  createUser() {
    let request = {
      "users": {
        "username": user.username,
        "email": user.email,
        "password": user.password
      }
    }
    axios.post('http://127.0.0.1:4000/api/users',JSON.stringify(request))
    .then(response => {})
    .catch(e => {
      this.errors.push(e)
    })
  }
}
</script>