const express = require("express");
const cors = require("cors"); // Import the CORS middleware
const app = express();
const port = process.env.PORT || 8080;

const bookRoutes = require("./routes/books");
const errorMiddleware = require("./middlewares/errorMiddleware");
const upload = require("./middlewares/imageUploadMiddleware");

app.use(cors()); // Enable CORS for all routes
app.use(express.json());

app.post("/photos", upload.single("avatar"), (req, res) => {
  res.send(req.file);
});

app.post("/photos/upload", upload.array("photos", 12), (req, res) => {
  res.send(req.files);
});

app.use(bookRoutes);
app.use(errorMiddleware);

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
