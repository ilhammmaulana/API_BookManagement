const Express = require("express");
const validationBook = require("../middlewares/validation/BookValidation");
const BookController = require("../controllers/BookController");
const verifyToken = require("../middlewares/verifiyToken");


const app = Express();
app.get("/books", verifyToken  , BookController.getAllBook);
app.get("/book/:id", BookController.getBook);
app.post("/book", validationBook, BookController.addBook);
app.patch("/book/:id", validationBook, BookController.editBook);
app.delete("/book/:id", BookController.deleteBook);

module.exports = app;
