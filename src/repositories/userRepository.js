const knex = require("../database/knex");

const getUserByUsername = (username) => {
  return knex("users").select("*").where({ username }).first();
};

const createUser = (username, password) => {
  return knex("users").insert({ username, password }).returning("*");
};

module.exports = { getUserByUsername, createUser };
