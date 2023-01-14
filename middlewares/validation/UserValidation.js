const { check, validationResult } = require("express-validator");

const rulesRegister = [
  check("username", "Username is required")
    .notEmpty()
    .matches(/^\S*$/)
    .withMessage("Username cannot contain spaces")
    .matches(/^[^%$^&*)()]+$/)
    .withMessage(`Username cannot contains attributes like : "%$^&*)("`)
    .isLength({
      min: 8,
      max: 30,
    })
    .withMessage("username min 8 max 30"),
  // Email
  check("email")
    .notEmpty()
    .withMessage("Email is required")
    .isEmail()
    .normalizeEmail()
    .withMessage("Email must be valid"),
  check("password", "Password is required")
    .notEmpty()
    .withMessage("password is required"),
  check("confirmPassword")
    .notEmpty()
    .withMessage("Confirm Password is required")
    .custom((value, { req }) => value === req.body.password)
    .withMessage("Confirm password and password not same"),
];

const validateResponse = (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  next();
};
const rulesLogin = [
  check("username")
    .notEmpty()
    .withMessage("Username is required for login")
    .matches(/^\S*$/)
    .withMessage("Username cannot contain spaces")
    .matches(/^[^%$^&*)()]+$/)
    .withMessage(`Username cannot contains attributes like : "%$^&*)("`)
    .isLength({
      min: 8,
      max: 30,
    })
    .withMessage("username min 8 max 30"),
  check("password").notEmpty().withMessage("Please enter a password"),
];

const login = [rulesLogin, validateResponse];
const register = [rulesRegister, validateResponse];
module.exports = { register, login };
