const knex = require("../database/knex");

const getAllBooks = async (limit, offset, search) => {
  const query = knex("books")
    .select("*")
    .whereNull("deleted_at") // Exclude logically deleted books
    .modify((builder) => {
      if (search) {
        builder.where("title", "ilike", `%${search}%`);
      }
    })
    .limit(limit)
    .offset(offset)
    .orderBy("title"); // Order by any suitable field

  // Create a count query for total records
  const countQuery = knex("books").whereNull("deleted_at");
  if (search) {
    countQuery.where("title", "ilike", `%${search}%`);
  }

  const [books, [{ totalRecords }]] = await Promise.all([
    query,
    countQuery.count("* as totalRecords"),
  ]);

  return { books, totalRecords: parseInt(totalRecords, 10) };
};

const createBook = (title, author, isbn) => {
  return knex("books").insert({ title, author, isbn }).returning("*");
};

const getBookById = (id) => {
  return knex("books").select("*").where({ id }).first();
};

const getBookBySlug = (slug) => {
  return knex("books").select("*").where({ slug }).first();
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
  return knex("books").where({ id }).update({ deleted_at: knex.fn.now() });
};

// Borrow a book
const borrowBook = async (id, userId) => {
  // Create a new borrowing record
  const [borrowedBook] = await knex("borrowed_books")
    .insert({ book_id: id, borrowed_at: new Date(), user_id: userId })
    .returning("*");

  // Update the book's status to borrowed
  await knex("books").where({ id }).update({ is_borrowed: true });

  return borrowedBook;
};

const hasBorrowBook = async (userId) => {
  const borrowedBook = await knex("borrowed_books")
    .select("*")
    .where({ user_id: userId })
    .first();

  if (borrowedBook) {
    return true;
  }

  return false;
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
  getBookBySlug,
  updateBook,
  deleteBook,
  borrowBook,
  returnBook,
  hasBorrowBook,
};
