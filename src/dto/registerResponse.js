class RegisterResponse {
  constructor(user) {
    this.id = user.id;
    this.username = user.username;
  }
}

module.exports = RegisterResponse;
