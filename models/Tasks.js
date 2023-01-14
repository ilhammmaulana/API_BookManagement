const { DataTypes } = require('sequelize');
const db = require('../config/Database');
const Tasks = db.define('task', {
    id_project: {
        type: DataTypes.INTEGER,
        require: true,
    },
    id_user: {
        type: DataTypes.INTEGER,
        require: true,
    },
    proggress: {
        type: DataTypes.STRING,
        require: true,
    },
    status: {
        type: DataTypes.STRING,
        require: true
    }
})
Tasks.sync()
module.exports = Tasks;