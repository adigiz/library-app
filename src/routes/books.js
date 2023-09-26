const express = require("express");
const router = express.Router();
const booksController = require("../controllers/bookController");
const { imageUpload } = require("../middlewares/imageUploadMiddleware");
const { adminMiddleware, authMiddleware } = require("../middlewares/authMiddleware");

// Books CRUD
router.get("/books", booksController.getAllBooks);
router.get("/books/:slug", booksController.getBookBySlug);
router.post(
  "/books",
  imageUpload.single("cover"),
  adminMiddleware,
  booksController.createBook
);
router.put("/books/:id", booksController.updateBook);
router.delete("/books/:id", booksController.deleteBook);

// Borrow and Return Books
router.post("/borrow/:id", authMiddleware, booksController.borrowBook);
router.post("/return/:id", booksController.returnBook);

module.exports = router;
