const Book = require("../models/Books");

const getAllBook = async (req, res) => {
  try {
    const response = await Book.findAll();
    res.status(200).json(response);
  } catch (error) {
    console.log(error.massage);
  }
};
const getBook = async (req, res) => {
  let status;
  try {
    const response = await Book.findOne({
      where: {
        id: req.params.id,
      },
    });
    if (response !== null) status = 200;
    res.status(status).json({
      msg: "OK",
      id: req.params.id,
      data: response,
      status: status,
    });
  } catch (error) {
    status = 404;
    res.status(status).json({
      request: {
        req_params: req.params,
        req_body: req.body,
      },
      error: {
        massage: "NOT FOUND",
      },
      status: status,
    });
  }
};

const addBook = async (req, res) => {
  try {
    await Book.create({
      tittle: req.body.tittle,
      desc: req.body.desc,
      writer: req.body.writer,
      year_release: req.body.year_release,
    });
    res.status(200).json({
      status: "Success",
      msg: "Book has added !!",
    });
  } catch (error) {
    console.log(error.massage);
  }
};

const editBook = async (req, res) => {
  try {
    const data = {
      tittle: req.body.tittle,
      desc: req.body.desc,
      writer: req.body.writer,
      year_release: req.body.year_release,
    };

    await Book.update(data, {
      where: {
        id: req.params.id,
      },
    });
    res.status(200).json({
      status: "Success",
      msg: "Book updated succesfully !!",
    });
  } catch (error) {
    console.log(error.massage);
  }
};

const deleteBook = async (req, res) => {
  try {
    await Book.destroy({
      where: {
        id: req.params.id,
      },
    });
    res.status(200).json({
      status: "Success",
      msg: "Book has deleted !!",
    });
  } catch (error) {
    console.log(error.massage);
  }
};

module.exports = { getAllBook, getBook, addBook, editBook, deleteBook };
