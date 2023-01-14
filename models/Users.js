const { Sequelize, DataTypes } = require("sequelize");
const db = require("../config/Database");
const User = db.define(
  "user",
  {
    username: {
      unique: true,
      require: true,
      type: DataTypes.STRING,
    },
    devisi: {
      require: true,
      type: DataTypes.STRING,
    },
    email: {
      type: DataTypes.STRING,
      require: true,
    },
    password: {
      type: DataTypes.STRING,
      require: true,
    },
    refresh_token: {
      type: DataTypes.STRING,
    },
  },
  {
    freezeTableName: false,
  }
);
// User.sync({ force: true });
module.exports = User;
