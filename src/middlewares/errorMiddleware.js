const {
  IMAGE_EXTENSION_ERROR,
  INTERNAL_SERVER_ERROR,
} = require("../sentinel/error");

const errorMiddleware = (err, req, res, next) => {
  console.error(err.stack);
  if (err.message == IMAGE_EXTENSION_ERROR) {
    return res.status(400).json({ error: err.message });
  }
  res.status(500).json({ error: INTERNAL_SERVER_ERROR });
};

module.exports = errorMiddleware;
