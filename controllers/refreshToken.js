const User = require("../models/Users");
const jwt = require("jsonwebtoken");

const refreshToken = async (req, res) => {
  try {
    const refreshToken = req.cookies.refreshToken;
    if (!refreshToken) return res.sendStatus(401);
    const user = await User.findOne({
      where: {
        refresh_token: refreshToken,
      },
    });
    const username = user.username;
    const id = user.id;
    const devisi = user.devisi;
    const email = user.email;
    const accessToken = jwt.sign(
      { id, username, email, devisi },
      process.env.ACCESS_TOKEN_SECRET,
      {
        expiresIn: "15s",
      }
    );
    res.json({ accessToken });
  } catch (error) {
    res.status(401);
  }
};

module.exports = refreshToken;
