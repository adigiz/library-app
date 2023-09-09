const bookService = require("../services/bookService");

const getAllBooks = async (req, res) => {
  const { page = 1, limit = 10 } = req.query;
  const offset = (page - 1) * limit;

  try {
    const books = await bookService.getAllBooks(limit, offset);
    res.json(books);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

const createBook = async (req, res) => {
  const { title, author, isbn } = req.body;
  if (!title || !author || !isbn) {
    return res.status(400).json({ error: "Missing required fields" });
  }

  try {
    const newBook = await bookService.createBook(title, author, isbn);
    res.status(201).json(newBook);
  } catch (error) {
    res.status(500).json({ error: "Internal Server Error" });
  }
};

const getBookById = async (req, res) => {
  const { id } = req.params;
  try {
    const book = await bookService.getBookById(id);
    if (!book) {
      return res.status(404).json({ error: "Book not found" });
    }
    res.json(book);
  } catch (error) {
    res.status(500).json({ error: "Internal Server Error" });
  }
};

// Update a book
const updateBook = async (req, res) => {
  const { id } = req.params;
  const { title, author, isbn } = req.body;
  if (!title || !author || !isbn) {
    return res.status(400).json({ error: "Missing required fields" });
  }

  try {
    const updatedBook = await bookService.updateBook(id, title, author, isbn);
    if (!updatedBook) {
      return res.status(404).json({ error: "Book not found" });
    }
    res.json(updatedBook);
  } catch (error) {
    res.status(500).json({ error: "Internal Server Error" });
  }
};

// Delete a book
const deleteBook = async (req, res) => {
  const { id } = req.params;
  try {
    const deletedBook = await bookService.deleteBook(id);
    if (!deletedBook) {
      return res.status(404).json({ error: "Book not found" });
    }
    res.json({ message: "Book deleted successfully" });
  } catch (error) {
    res.status(500).json({ error: "Internal Server Error" });
  }
};

// Borrow a book
const borrowBook = async (req, res) => {
  const { id } = req.params;
  try {
    const borrowedBook = await bookService.borrowBook(id);
    if (!borrowedBook) {
      return res.status(404).json({ error: "Book not found" });
    }
    res.json({ message: "Book borrowed successfully" });
  } catch (error) {
    res.status(500).json({ error: "Internal Server Error" });
  }
};

// Return a book
const returnBook = async (req, res) => {
  const { id } = req.params;
  try {
    const returnedBook = await bookService.returnBook(id);
    if (!returnedBook) {
      return res.status(404).json({ error: "Book not found" });
    }
    res.json({ message: "Book returned successfully" });
  } catch (error) {
    res.status(500).json({ error: "Internal Server Error" });
  }
};

module.exports = {
  getAllBooks,
  getBookById,
  createBook,
  updateBook,
  deleteBook,
  borrowBook,
  returnBook,
};