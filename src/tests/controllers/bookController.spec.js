const bookService = require("../../services/bookService"); // Import the real service
const bookController = require("../../controllers/bookController");

// Mock the bookService module
jest.mock("../../services/bookService", () => ({
  createBook: jest.fn(),
}));

  const mockReq = (body = {}, params = {}, query = {}) => {
    return {
      body: body,
      params: params,
      query: query,
    };
  };

  const mockRes = () => {
    const res = {};
    res.json = jest.fn().mockReturnValue(res);
    res.status = jest.fn().mockReturnValue(res);
    return res;
  };

describe("Book Controller", () => {
  describe("POST /books", () => {
    it("should create new book", async () => {
      const data = {
        title: "Harry Potter",
        author: "JK Rowling",
        isbn: "9172n30syo8",
      };
      const req = mockReq(data);
      const response = mockRes();
      bookService.createBook.mockResolvedValue(data);

      await bookController.createBook(req, response);

      expect(response.status).toHaveBeenCalledWith(201); // Check status code
      expect(response.json).toHaveBeenCalledWith(data); // Check response data
    });
  });
});

// describe("Book Controller", () => {
//   // Test the createBook function
//   describe("POST /books", () => {
//     it("should create a new book", async () => {
//       const bookData = {
//         title: "Sample Book",
//         author: "John Doe",
//         isbn: "1234567890",
//       };
//       // Mock the bookService.createBook implementation
//       bookService.createBook.mockResolvedValue(bookData);

//       const response = await bookController.createBook(
//         mockReq(bookData),
//         mockRes
//       );

//       expect(response.status).toBe(201);
//       expect(response.body).toEqual(bookData);
//     });
//   });
// });
