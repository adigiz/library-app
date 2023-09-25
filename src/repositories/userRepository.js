const knex = require("../database/knex");

const getUserByUsername = (username) => {
  return knex("users").select("*").where({ username }).first();
};

const getUserById = (id) => {
  return knex("users").where({ id }).first();
};

const createUser = (username, password) => {
  return knex("users").insert({ username, password }).returning("*");
};

const authenticate = async (payload, done) => {
  try {
    const user = await getUserById(payload.id);
    return done(null, user);
  } catch (error) {
    return done(error, { error: unauthorized });
  }
};

module.exports = { getUserByUsername, createUser, authenticate, getUserById };
