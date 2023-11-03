class BookRequest {
    constructor(req) {
        this.search = req.search;
        this.limit = req.limit;
        this.offset = req.offset;
        this.sort = req.sort;
        this.sortBy = req.sortBy;
      }
}

module.exports = BookRequest