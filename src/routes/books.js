// src/routes/libraryRoutes.js
const express = require("express");
const router = express.Router();
const booksController = require("../controllers/bookController");

// Books CRUD
router.get("/books", booksController.getAllBooks);
router.get("/books/:id", booksController.getBookById);
router.post("/books", booksController.createBook);
router.put("/books/:id", booksController.updateBook);
router.delete("/books/:id", booksController.deleteBook);

// Borrow and Return Books
router.post("/borrow/:id", booksController.borrowBook);
router.post("/return/:id", booksController.returnBook);

module.exports = router;
