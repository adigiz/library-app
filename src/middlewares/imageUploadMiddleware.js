const fs = require("fs");
const multer = require("multer");
const cloudinary = require("cloudinary");
const customError = require("../sentinel/error");

cloudinary.config({
  cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_SECRET,
});

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

const uploadToCloud = async (filePath) => {
  let result;
  try {
    result = await cloudinary.uploader.upload(filePath, { use_filename: true });
    fs.unlinkSync(filePath);
    return result.url;
  } catch (err) {
    fs.unlinkSync(filePath);
    return null;
  }
};

module.exports = { imageUpload, uploadToCloud };
