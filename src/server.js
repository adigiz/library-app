const express = require("express");
const cors = require("cors"); // Import the CORS middleware
const app = express();
const port = process.env.PORT || 8080;

const bookRoutes = require("./routes/books");
const errorMiddleware = require("./middlewares/errorMiddleware");

app.use(cors()); // Enable CORS for all routes
app.use(express.json());

app.use(bookRoutes);
app.use(errorMiddleware);

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
