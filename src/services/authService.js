const bcrypt = require("bcrypt");

const userRepository = require("../repositories/userRepository");
const { USERNAME_ALREADY_EXIST_ERROR } = require("../sentinel/error");

const register = (username, password) => {
  try {
    const encryptedPassword = bcrypt.hashSync(password, 10);
    const user = userRepository.getUserByUsername(username, encryptedPassword);
    if (user) {
      throw new Error(USERNAME_ALREADY_EXIST_ERROR);
    }

    return userRepository.createUser(username, password);
  } catch (error) {
    throw error;
  }
};

const login = (username, password) => {
  try {
    const user = userRepository.getUserByUsername(username);
    if (!user) {
      throw new Error("wrong username or password");
    }

    const isPasswordValid = bcrypt.compareSync(password, user.password);
    if (!isPasswordValid) {
      throw new Error("wrong username or password");
    }

    return { id: user.id, username: user.username };
  } catch (error) {
    throw error;
  }
};
module.exports = { register, login };
