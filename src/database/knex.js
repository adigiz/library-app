require("dotenv").config();

const conn = {
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE,
};

const knex = require("knex")({
  client: "pg",
  connection:
    process.env.ENVIRONMENT === "PRODUCTION" ? process.env.DB_URL + "?sslmode=require" : conn,
  migrations: {
    tableName: "knex-migrations",
  },
});

module.exports = knex;
