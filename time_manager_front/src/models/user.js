export default class User {
    constructor(username, email, password, password_confirmation, userId, jwt) {
      this.username = username;
      this.email = email;
      this.password = password;
      this.password_confirmation = password_confirmation;
      this.userId = userId;
      this.jwt = jwt
    }
  }