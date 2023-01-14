const sequelize = require("sequelize");
const User = require("../models/Users");
const bycrpt = require("bcrypt");
const jwt = require("jsonwebtoken");
const dotenv = require("dotenv");
const { where } = require("sequelize");
// GET ALL USER
const getAllUser = async (req, res) => {
  try {
    const response = await User.findAll({
      attributes: {
        exclude: ["password", "refresh_token"],
      },
    });
    const users = response.filter(
      (user) => user.devisi !== "superAdmin" && user.devisi !== "PSDM"
    );
    res.status(200).json({
      status: 200,
      msg: "OK",
      data: users,
    });
  } catch (error) {
    console.log(error);
  }
};

// Register
const register = async (req, res) => {
  try {
    const { username, email, password, confirmPassword, devisi } = req.body;
    if (password !== confirmPassword) {
      return res.status(400).json({
        msg: "Password must be same !!",
      });
    }
    const salt = await bycrpt.genSalt();
    const hashPassword = await bycrpt.hash(password, salt);
    const response = await User.create({
      username,
      email,
      devisi,
      password: hashPassword,
    });

    res.status(200).json({
      msg: "success register",
      response,
    });
  } catch (error) {
    console.log(error.errors);
    res.status(400).json({
      status: 400,
      msg: "Error, Data must be valid",
      error: error.errors,
    });
  }
};
// Login
const login = async (req, res) => {
  try {
    const user = await User.findOne({
      where: {
        username: req.body.username,
      },
    });
    // if (user === undefined) {
    //   throw new Error("okw");
    // }
    const password = user.password;
    const match = await bycrpt.compare(req.body.password, password);
    if (!match) {
      return res.status(403).json({
        status: 403,
        msg: "password salah",
      });
    }
    const username = user.username;
    const email = user.email;
    const id = user.id;
    const devisi = user.devisi;
    const accessToken = jwt.sign(
      { id, username, email, devisi },
      process.env.ACCESS_TOKEN_SECRET,
      {
        expiresIn: "10s",
      }
    );
    const refreshToken = jwt.sign(
      { id, username, email, devisi },
      process.env.REFRESH_TOKEN_SECRET,
      {
        expiresIn: "1d",
      }
    );
    await User.update(
      {
        refresh_token: refreshToken,
      },
      {
        where: {
          id,
        },
      }
    );
    res.cookie("refreshToken", refreshToken, {
      httpOnly: true,
      maxAge: 24 * 60 * 60 * 1000,
      // secure: true,
    });

    res.status(200).json({
      msg: "Login successfuly",
      status: 200,
      accessToken,
    });
  } catch (error) {
    console.log(error.massage);
    const status = 401;
    res.status(status).json({
      msg: "Username or password wrong",
    });
  }
};
const logout = async (req, res) => {
  try {
    const refreshToken = req.cookies.refreshToken;
    if (!refreshToken) return res.sendStatus(401);
    const user = await User.findOne({
      where: {
        refresh_token: refreshToken,
      },
    });
    await User.update(
      { refreshToken: null },
      {
        where: {
          id: user.id,
        },
      }
    );
    res.clearCookie("refreshToken").sendStatus(204);
  } catch (error) {
    console.log(error);
    res.status(400).json({ error });
  }
};
module.exports = {
  getAllUser,
  register,
  login,
  logout,
};
