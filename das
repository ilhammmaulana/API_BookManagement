[33mcommit 35981edd266aee417016b4225459f86911d6f7ad[m[33m ([m[1;36mHEAD -> [m[1;32mmain[m[33m, [m[1;31morigin/master[m[33m)[m
Author: Ilham Maulana <ilhammmaulana688@gmail.com>
Date:   Fri Jan 13 21:35:19 2023 +0700

    initial commit

[1mdiff --git a/.env b/.env[m
[1mnew file mode 100644[m
[1mindex 0000000..cd8d6ce[m
[1m--- /dev/null[m
[1m+++ b/.env[m
[36m@@ -0,0 +1,11 @@[m
[32m+[m[32mDB_NAME = project_d[m
[32m+[m[32mDB_USERNAME = root[m
[32m+[m[32mDB_PASSWORD=''[m
[32m+[m[32mDB_HOST = localhost[m
[32m+[m[32mSERVER_PORT = 5000[m
[32m+[m[32mDB_CONNECTION = mysql[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32mACCESS_TOKEN_SECRET = jkasdkjb37898ahs1d4khb00328dkasdasdsdak192[m
[32m+[m[32mREFRESH_TOKEN_SECRET = qweiojkjkj290edjo0912ozckkjssdaads928398s[m
[1mdiff --git a/README.MD b/README.MD[m
[1mnew file mode 100644[m
[1mindex 0000000..7cfcd3a[m
[1m--- /dev/null[m
[1m+++ b/README.MD[m
[36m@@ -0,0 +1,11 @@[m
[32m+[m[32mAPI SEDERHANA[m[41m [m
[32m+[m[32mFiture[m[41m [m
[32m+[m[32m-Login[m
[32m+[m[32m-Register[m
[32m+[m
[32m+[m[32mUser Roles Devisi[m
[32m+[m[32m-Super Admin[m
[32m+[m[32m-PSDM[m
[32m+[m[32m-web developer[m
[32m+[m[32m-android developer[m
[32m+[m
[1mdiff --git a/app.js b/app.js[m
[1mnew file mode 100644[m
[1mindex 0000000..76861fe[m
[1m--- /dev/null[m
[1m+++ b/app.js[m
[36m@@ -0,0 +1,18 @@[m
[32m+[m[32mconst express = require("express");[m
[32m+[m[32mconst Book = require("./routes/BookRoutes");[m
[32m+[m[32mconst User = require("./routes/UserRoutes");[m
[32m+[m[32mconst cors = require("cors");[m
[32m+[m[32mconst dotenv = require("dotenv");[m
[32m+[m[32mconst cookieParsser = require("cookie-parser");[m
[32m+[m[32mdotenv.config();[m
[32m+[m
[32m+[m[32mconst app = express();[m
[32m+[m[32mapp.use(cors({ credentials: true, origin: "http://localhost:3000" }));[m
[32m+[m[32mapp.use(cookieParsser());[m
[32m+[m[32mapp.use(express.json());[m
[32m+[m[32mconst port = process.env.SERVER_PORT;[m
[32m+[m[32mapp.use(Book);[m
[32m+[m[32mapp.use(User);[m
[32m+[m[32mapp.listen(port, () => {[m
[32m+[m[32m  console.log("Server running at http://localhost:" + port);[m
[32m+[m[32m});[m
[1mdiff --git a/config/Database.js b/config/Database.js[m
[1mnew file mode 100644[m
[1mindex 0000000..34db4c5[m
[1m--- /dev/null[m
[1m+++ b/config/Database.js[m
[36m@@ -0,0 +1,18 @@[m
[32m+[m[32mconst dotenv = require("dotenv");[m
[32m+[m[32mdotenv.config();[m
[32m+[m[32mconst Sequelize = require("sequelize");[m
[32m+[m[32mconst DB_NAME = process.env.DB_NAME;[m
[32m+[m[32mconst DB_USERNAME = process.env.DB_USERNAME;[m
[32m+[m[32mconst DB_PASSWORD = process.env.DB_PASSWORD;[m
[32m+[m
[32m+[m[32mconst db = new Sequelize(DB_NAME, DB_USERNAME, DB_PASSWORD, {[m
[32m+[m[32m  host: "localhost",[m
[32m+[m[32m  dialect: "mysql",[m
[32m+[m[32m});[m
[32m+[m[32mtry {[m
[32m+[m[32m  db.authenticate();[m
[32m+[m[32m  console.log('Database connected ...')[m
[32m+[m[32m} catch (error) {[m
[32m+[m[32m  console.log(error)[m
[32m+[m[32m}[m
[32m+[m[32mmodule.exports = db;[m
\ No newline at end of file[m
[1mdiff --git a/controllers/BookController.js b/controllers/BookController.js[m
[1mnew file mode 100644[m
[1mindex 0000000..cb205c1[m
[1m--- /dev/null[m
[1m+++ b/controllers/BookController.js[m
[36m@@ -0,0 +1,97 @@[m
[32m+[m[32mconst Book = require("../models/Books");[m
[32m+[m
[32m+[m[32mconst getAllBook = async (req, res) => {[m
[32m+[m[32m  try {[m
[32m+[m[32m    const response = await Book.findAll();[m
[32m+[m[32m    res.status(200).json(response);[m
[32m+[m[32m  } catch (error) {[m
[32m+[m[32m    console.log(error.massage);[m
[32m+[m[32m  }[m
[32m+[m[32m};[m
[32m+[m[32mconst getBook = async (req, res) => {[m
[32m+[m[32m  let status;[m
[32m+[m[32m  try {[m
[32m+[m[32m    const response = await Book.findOne({[m
[32m+[m[32m      where: {[m
[32m+[m[32m        id: req.params.id,[m
[32m+[m[32m      },[m
[32m+[m[32m    });[m
[32m+[m[32m    if (response !== null) status = 200;[m
[32m+[m[32m    res.status(status).json({[m
[32m+[m[32m      msg: "OK",[m
[32m+[m[32m      id: req.params.id,[m
[32m+[m[32m      data: response,[m
[32m+[m[32m      status: status,[m
[32m+[m[32m    });[m
[32m+[m[32m  } catch (error) {[m
[32m+[m[32m    status = 404;[m
[32m+[m[32m    res.status(status).json({[m
[32m+[m[32m      request: {[m
[32m+[m[32m        req_params: req.params,[m
[32m+[m[32m        req_body: req.body,[m
[32m+[m[32m      },[m
[32m+[m[32m      error: {[m
[32m+[m[32m        massage: "NOT FOUND",[m
[32m+[m[32m      },[m
[32m+[m[32m      status: status,[m
[32m+[m[32m    });[m
[32m+[m[32m  }[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mconst addBook = async (req, res) => {[m
[32m+[m[32m  try {[m
[32m+[m[32m    await Book.create({[m
[32m+[m[32m      tittle: req.body.tittle,[m
[32m+[m[32m      desc: req.body.desc,[m
[32m+[m[32m      writer: req.body.writer,[m
[32m+[m[32m      year_release: req.body.year_release,[m
[32m+[m[32m    });[m
[32m+[m[32m    res.status(200).json({[m
[32m+[m[32m      status: "Success",[m
[32m+[m[32m      msg: "Book has added !!",[m
[32m+[m[32m    });[m
[32m+[m[32m  } catch (error) {[m
[32m+[m[32m    console.log(error.massage);[m
[32m+[m[32m  }[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mconst editBook = async (req, res) => {[m
[32m+[m[32m  try {[m
[32m+[m[32m    const data = {[m
[32m+[m[32m      tittle: req.body.tittle,[m
[32m+[m[32m      desc: req.body.desc,[m
[32m+[m[32m      writer: req.body.writer,[m
[32m+[m[32m      year_release: req.body.year_release,[m
[32m+[m[32m    };[m
[32m+[m
[32m+[m[32m    await Book.update(data, {[m
[32m+[m[32m      where: {[m
[32m+[m[32m        id: req.params.id,[m
[32m+[m[32m      },[m
[32m+[m[32m    });[m
[32m+[m[32m    res.status(200).json({[m
[32m+[m[32m      status: "Success",[m
[32m+[m[32m      msg: "Book updated succesfully !!",[m
[32m+[m[32m    });[m
[32m+[m[32m  } catch (error) {[m
[32m+[m[32m    console.log(error.massage);[m
[32m+[m[32m  }[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mconst deleteBook = async (req, res) => {[m
[32m+[m[32m  try {[m
[32m+[m[32m    await Book.destroy({[m
[32m+[m[32m      where: {[m
[32m+[m[32m        id: req.params.id,[m
[32m+[m[32m      },[m
[32m+[m[32m    });[m
[32m+[m[32m    res.status(200).json({[m
[32m+[m[32m      status: "Success",[m
[32m+[m[32m      msg: "Book has deleted !!",[m
[32m+[m[32m    });[m
[32m+[m[32m  } catch (error) {[m
[32m+[m[32m    console.log(error.massage);[m
[32m+[m[32m  }[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mmodule.exports = { getAllBook, getBook, addBook, editBook, deleteBook };[m
[1mdiff --git a/controllers/UserController.js b/controllers/UserController.js[m
[1mnew file mode 100644[m
[1mindex 0000000..786e2e5[m
[1m--- /dev/null[m
[1m+++ b/controllers/UserController.js[m
[36m@@ -0,0 +1,153 @@[m
[32m+[m[32mconst sequelize = require("sequelize");[m
[32m+[m[32mconst User = require("../models/Users");[m
[32m+[m[32mconst bycrpt = require("bcrypt");[m
[32m+[m[32mconst jwt = require("jsonwebtoken");[m
[32m+[m[32mconst dotenv = require("dotenv");[m
[32m+[m[32mconst { where } = require("sequelize");[m
[32m+[m[32m// GET ALL USER[m
[32m+[m[32mconst getAllUser = async (req, res) => {[m
[32m+[m[32m  try {[m
[32m+[m[32m    const response = await User.findAll({[m
[32m+[m[32m      attributes: {[m
[32m+[m[32m        exclude: ["password", "refresh_token"],[m
[32m+[m[32m      },[m
[32m+[m[32m    });[m
[32m+[m[32m    const users = response.filter([m
[32m+[m[32m      (user) => user.devisi !== "superAdmin" && user.devisi !== "PSDM"[m
[32m+[m[32m    );[m
[32m+[m[32m    res.status(200).json({[m
[32m+[m[32m      status: 200,[m
[32m+[m[32m      msg: "OK",[m
[32m+[m[32m      data: users,[m
[32m+[m[32m    });[m
[32m+[m[32m  } catch (error) {[m
[32m+[m[32m    console.log(error);[m
[32m+[m[32m  }[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32m// Register[m
[32m+[m[32mconst register = async (req, res) => {[m
[32m+[m[32m  try {[m
[32m+[m[32m    const { username, email, password, confirmPassword, devisi } = req.body;[m
[32m+[m[32m    if (password !== confirmPassword) {[m
[32m+[m[32m      return res.status(400).json({[m
[32m+[m[32m        msg: "Password must be same !!",[m
[32m+[m[32m      });[m
[32m+[m[32m    }[m
[32m+[m[32m    const salt = await bycrpt.genSalt();[m
[32m+[m[32m    const hashPassword = await bycrpt.hash(password, salt);[m
[32m+[m[32m    const response = await User.create({[m
[32m+[m[32m      username,[m
[32m+[m[32m      email,[m
[32m+[m[32m      devisi,[m
[32m+[m[32m      password: hashPassword,[m
[32m+[m[32m    });[m
[32m+[m
[32m+[m[32m    res.status(200).json({[m
[32m+[m[32m      msg: "success register",[m
[32m+[m[32m      response,[m
[32m+[m[32m    });[m
[32m+[m[32m  } catch (error) {[m
[32m+[m[32m    console.log(error.errors);[m
[32m+[m[32m    res.status(400).json({[m
[32m+[m[32m      status: 400,[m
[32m+[m[32m      msg: "Error, Data must be valid",[m
[32m+[m[32m      error: error.errors,[m
[32m+[m[32m    });[m
[32m+[m[32m  }[m
[32m+[m[32m};[m
[32m+[m[32m// Login[m
[32m+[m[32mconst login = async (req, res) => {[m
[32m+[m[32m  try {[m
[32m+[m[32m    const user = await User.findOne({[m
[32m+[m[32m      where: {[m
[32m+[m[32m        username: req.body.username,[m
[32m+[m[32m      },[m
[32m+[m[32m    });[m
[32m+[m[32m    // if (user === undefined) {[m
[32m+[m[32m    //   throw new Error("okw");[m
[32m+[m[32m    // }[m
[32m+[m[32m    const password = user.password;[m
[32m+[m[32m    const match = await bycrpt.compare(req.body.password, password);[m
[32m+[m[32m    if (!match) {[m
[32m+[m[32m      return res.status(403).json({[m
[32m+[m[32m        status: 403,[m
[32m+[m[32m        msg: "password salah",[m
[32m+[m[32m      });[m
[32m+[m[32m    }[m
[32m+[m[32m    const username = user.username;[m
[32m+[m[32m    const email = user.email;[m
[32m+[m[32m    const id = user.id;[m
[32m+[m[32m    const devisi = user.devisi;[m
[32m+[m[32m    const accessToken = jwt.sign([m
[32m+[m[32m      { id, username, email, devisi },[m
[32m+[m[32m      process.env.ACCESS_TOKEN_SECRET,[m
[32m+[m[32m      {[m
[32m+[m[32m        expiresIn: "10s",[m
[32m+[m[32m      }[m
[32m+[m[32m    );[m
[32m+[m[32m    const refreshToken = jwt.sign([m
[32m+[m[32m      { id, username, email, devisi },[m
[32m+[m[32m      process.env.REFRESH_TOKEN_SECRET,[m
[32m+[m[32m      {[m
[32m+[m[32m        expiresIn: "1d",[m
[32m+[m[32m      }[m
[32m+[m[32m    );[m
[32m+[m[32m    await User.update([m
[32m+[m[32m      {[m
[32m+[m[32m        refresh_token: refreshToken,[m
[32m+[m[32m      },[m
[32m+[m[32m      {[m
[32m+[m[32m        where: {[m
[32m+[m[32m          id,[m
[32m+[m[32m        },[m
[32m+[m[32m      }[m
[32m+[m[32m    );[m
[32m+[m[32m    res.cookie("refreshToken", refreshToken, {[m
[32m+[m[32m      httpOnly: true,[m
[32m+[m[32m      maxAge: 24 * 60 * 60 * 1000,[m
[32m+[m[32m      // secure: true,[m
[32m+[m[32m    });[m
[32m+[m
[32m+[m[32m    res.status(200).json({[m
[32m+[m[32m      msg: "Login successfuly",[m
[32m+[m[32m      status: 200,[m
[32m+[m[32m      accessToken,[m
[32m+[m[32m    });[m
[32m+[m[32m  } catch (error) {[m
[32m+[m[32m    console.log(error.massage);[m
[32m+[m[32m    const status = 401;[m
[32m+[m[32m    res.status(status).json({[m
[32m+[m[32m      msg: "Username or password wrong",[m
[32m+[m[32m    });[m
[32m+[m[32m  }[m
[32m+[m[32m};[m
[3