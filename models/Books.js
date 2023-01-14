const db = require("../config/Database");
const { DataTypes, Sequelize } = require("sequelize");

const Book = db.define(
  "Book",
  {
    tittle: {
      type: DataTypes.STRING,
    },
    desc: {
      type: DataTypes.TEXT,
    },
    writer: {
      type: DataTypes.STRING,
    },
    year_release: {
      type: DataTypes.STRING,
    },
  },
  {
    timestamps: false,
  }
);
// (async () => {
//   await db.sync();
// })();

module.exports = Book;
