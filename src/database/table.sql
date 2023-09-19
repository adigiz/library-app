-- Create the 'books' table
CREATE TABLE books (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  author VARCHAR(255) NOT NULL,
  isbn VARCHAR(13) NOT NULL,
  is_borrowed BOOLEAN DEFAULT FALSE
);

-- Create the 'borrowed_books' table to track book borrowings
CREATE TABLE borrowed_books (
  id SERIAL PRIMARY KEY,
  book_id INTEGER REFERENCES books(id),
  user_id INTEGER,
  borrowed_at TIMESTAMP NOT NULL DEFAULT NOW(),
  returned_at TIMESTAMP
);
