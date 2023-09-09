const logMiddleware = (req, res, next) => {
  // Get the current timestamp for logging
  const timestamp = new Date().toISOString();

  // Log the incoming request
  console.log(`${timestamp} - ${req.method} ${req.url}`);

  // Continue to the next middleware/route handler
  next();
};

module.exports = logMiddleware;
