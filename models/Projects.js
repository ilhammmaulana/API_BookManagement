const { DataTypes } = require("sequelize");
const db = require("../config/Database");
const Projects = db.define("project", {
  id_user: {
    type: DataTypes.STRING,
  },
  level_project: {
    type: DataTypes.STRING,
  },
  username: {
    type: DataTypes.STRING(50),
  },
  proggress: {
    type: DataTypes.STRING,
  },
  deskripsi_project: {
    type: DataTypes.TEXT,
  },
});



Projects.sync()
module.exports = Projects;