const { body, validationResult } = require("express-validator");

const rules = [
  body("tittle")
    .notEmpty()
    .isString()
    .isLength({ min: 7, max: 100 })
    .withMessage("tittle must to be min 7 character max 100 character"),
  body("desc")
    .notEmpty()
    .isString()
    .isLength({ min: 20, max: 255 })
    .withMessage(
      "description a book must to be 20 character max 255 character"
    ),

  body("writer")
    .notEmpty()
    .isString()
    .isLength({ min: 3, max: 100 })
    .withMessage("writter must to be min 3 character and max 100 character"),
  body("year_release")
    .notEmpty()
    .isString()
    .isLength({ min: 4, max: 4 })
    .withMessage("year release only 4 character ! example : 2017"),
];

const validationBook = [
  rules,
  (req, res, next) => {
    const errors = valsidationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        status: 400,
        massage: errors.array(),
      });
    }
    next();
  },
];

module.exports = validationBook;
