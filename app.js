const express = require("express");
const Book = require("./routes/BookRoutes");
const User = require("./routes/UserRoutes");
const cors = require("cors");
const dotenv = require("dotenv");
const cookieParsser = require("cookie-parser");
dotenv.config();

const app = express();
app.use(cors({ credentials: true, origin: "http://localhost:3000" }));
app.use(cookieParsser());
app.use(express.json());
const port = process.env.SERVER_PORT;
app.use(Book);
app.use(User);
app.listen(port, () => {
  console.log("Server running at http://localhost:" + port);
});
