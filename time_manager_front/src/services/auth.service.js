import axios from 'axios';
import User from '../models/user';

const API_URL = 'http://127.0.0.1:4000/api/users/';

class AuthService {
  login(user) {
    return axios
      .post(API_URL + 'sign_in', {
        email: user.email,
        password: user.password
      })
      .then(response => {
        console.log("test");
        let userObj = new User('', user.email, user.password, user.password, '', response.data.jwt)

        return axios.get('http://127.0.0.1:4000/api/v1/users?email='+user.email)
        .then(resp => {
          userObj.userId = resp.data.data.id;
          userObj.username = resp.data.data.username;
          localStorage.setItem('user', JSON.stringify(userObj));
          console.log(JSON.stringify(userObj))
          
        })
      });
  }

  logout() {
    localStorage.removeItem('user');
  }

  register(user) {
    return axios.post(API_URL + 'sign_up', {
      user: {
        username: user.username,
        email: user.email,
        password: user.password,
        password_confirmation: user.password_confirmation
      }
    });
  }
}

export default new AuthService();