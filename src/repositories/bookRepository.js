const knex = require("../database/knex");

const getAllBooks = (limit, offset) => {
  return knex("books").select("*").limit(limit).offset(offset).orderBy("title");
};

const createBook = (title, author, isbn) => {
  return knex("books").insert({ title, author, isbn }).returning("*");
};

const getBookById = (id) => {
  return knex("books").select("*").where({ id }).first();
};

// Update a book
const updateBook = (id, title, author, isbn) => {
  return knex("books")
    .where({ id })
    .update({ title, author, isbn })
    .returning("*");
};

// Delete a book
const deleteBook = (id) => {
  return knex("books").where({ id }).del().returning("*");
};

// Borrow a book
const borrowBook = async (id) => {
  const book = await getBookById(id);
  if (!book || book.is_borrowed) {
    return null; // Book not found or already borrowed
  }

  // Create a new borrowing record
  const [borrowedBook] = await knex("borrowed_books")
    .insert({ book_id: id, borrowed_at: new Date() })
    .returning("*");

  // Update the book's status to borrowed
  await knex("books").where({ id }).update({ is_borrowed: true });

  return borrowedBook;
};

// Return a book
const returnBook = async (id) => {
  const book = await getBookById(id);
  if (!book || !book.is_borrowed) {
    return null; // Book not found or not borrowed
  }

  // Find the latest borrowing record for the book
  const latestBorrowingRecord = await knex("borrowed_books")
    .where({ book_id: id, returned_at: null })
    .orderBy("borrowed_at", "desc")
    .first();

  if (!latestBorrowingRecord) {
    return null; // No active borrowing record found
  }

  // Update the borrowing record with the return date
  const [returnedBook] = await knex("borrowed_books")
    .where({ id: latestBorrowingRecord.id })
    .update({ returned_at: new Date() })
    .returning("*");

  // Update the book's status to not borrowed
  await knex("books").where({ id }).update({ is_borrowed: false });

  return returnedBook;
};

module.exports = {
  getAllBooks,
  createBook,
  getBookById,
  updateBook,
  deleteBook,
  borrowBook,
  returnBook,
};
