const bookRepository = require("../repositories/bookRepository");

const getAllBooks = async (bookReq) => {
  const { books, totalRecords } = await bookRepository.getAllBooks(bookReq);
  return { books, totalRecords };
};

const createBook = (req) => {
  return bookRepository.createBook(req);
};
// Get a book by ID
const getBookById = (id) => {
  return bookRepository.getBookById(id);
};

const getBookBySlug = (slug) => {
  return bookRepository.getBookBySlug(slug);
};

// Update a book
const updateBook = (id, title, author, isbn) => {
  return bookRepository.updateBook(id, title, author, isbn);
};

// Delete a book
const deleteBook = (id) => {
  return bookRepository.deleteBook(id);
};

// Borrow a book
const borrowBook = async (id, userId) => {
  try {
    const book = await bookRepository.getBookById(id);
    if (!book || book.is_borrowed) {
      throw new Error("book unavailable to borrow"); // Book not found or already borrowed
    }

    const hasBorrowed = await bookRepository.hasBorrowBook(userId);
    if (hasBorrowed) {
      throw new Error("can only borrow one book at a time");
    }

    return bookRepository.borrowBook(id);
  } catch (error) {
    throw error;
  }
};

// Return a book
const returnBook = (id) => {
  return bookRepository.returnBook(id);
};

module.exports = {
  getAllBooks,
  createBook,
  getBookById,
  getBookBySlug,
  updateBook,
  deleteBook,
  borrowBook,
  returnBook,
};
