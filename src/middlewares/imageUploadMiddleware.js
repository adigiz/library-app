const multer = require("multer");
const customError = require("../sentinel/error");
const storage = multer.diskStorage({
  destination: function (req, file, callback) {
    callback(null, "./src/uploads");
  },
  filename: function (req, file, callback) {
    callback(null, file.originalname);
  },
});

const imageUpload = multer({
  storage: storage,
  fileFilter: (req, file, callback) => {
    if (
      file.mimetype == "image/png" ||
      file.mimetype == "image/jpg" ||
      file.mimetype == "image/jpeg"
    ) {
      return callback(null, true);
    }
    callback(null, false);
    return callback(new Error(customError.IMAGE_EXTENSION_ERROR));
  },
});

module.exports = imageUpload;
