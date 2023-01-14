const dotenv = require("dotenv");
dotenv.config();
const Sequelize = require("sequelize");
const DB_NAME = process.env.DB_NAME;
const DB_USERNAME = process.env.DB_USERNAME;
const DB_PASSWORD = process.env.DB_PASSWORD;

const db = new Sequelize(DB_NAME, DB_USERNAME, DB_PASSWORD, {
  host: "localhost",
  dialect: "mysql",
});
try {
  db.authenticate();
  console.log('Database connected ...')
} catch (error) {
  console.log(error)
}
module.exports = db;