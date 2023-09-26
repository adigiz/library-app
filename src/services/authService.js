const bcrypt = require("bcrypt");

const userRepository = require("../repositories/userRepository");
const { USERNAME_ALREADY_EXIST_ERROR, WRONG_CREDENTIALS_ERROR } = require("../sentinel/error");

const register = async (username, password) => {
  try {
    const encryptedPassword = bcrypt.hashSync(password, 10);
    const user = await userRepository.getUserByUsername(username);

    if (user) {
      throw new Error(USERNAME_ALREADY_EXIST_ERROR);
    }

    return userRepository.createUser(username, encryptedPassword);
  } catch (error) {
    throw error;
  }
};

const login = async (username, password) => {
  try {
    const user = await userRepository.getUserByUsername(username);
    if (!user) {
      throw new Error(WRONG_CREDENTIALS_ERROR);
    }

    const isPasswordValid = bcrypt.compareSync(password, user.password);

    if (!isPasswordValid) {
      throw new Error(WRONG_CREDENTIALS_ERROR);
    }

    return { id: user.id, username: user.username };
  } catch (error) {
    throw error;
  }
};
module.exports = { register, login };
