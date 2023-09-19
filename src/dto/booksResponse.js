class BookResponse {
  constructor(book) {
    this.title = book.title;
    this.imageurl = book.imageurl;
    this.author = book.author;
    this.slud = book.slug;
    this.id = book.id;
    this.published_date = book.published_date;
  }
}

module.exports = BookResponse;
