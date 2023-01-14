const UserControllers = require("../controllers/UserController");
const verifyToken = require("../middlewares/verifiyToken");
const express = require("express");
const refreshToken = require("../controllers/refreshToken");
const validateUser = require("../middlewares/validation/UserValidation");

const app = express();
app.get("/users", verifyToken, UserControllers.getAllUser);
app.post("/user/register", UserControllers.register);
app.post("/login", validateUser.login, UserControllers.login);
app.get("/refresh-token", refreshToken);
app.delete("/logout", UserControllers.logout);

module.exports = app;
