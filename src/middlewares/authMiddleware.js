const passport = require("../lib/passport");
const authMiddleware = passport.authenticate("jwt", { session: false });
const adminMiddleware = (req, res, next) => {
  return passport.authenticate("jwt", { session: false }, (err, user, info) => {
    if (err) {
      console.log(err);
      return next(err);
    }
    if (!user) {
      return res.status(401).json({
        error: "user unauthorized",
      });
    }

    if (!user.is_admin) {
      return res.status(403).json({
        error: "access denied",
      });
    }
    // Forward user information to the next middleware
    req.user = user;
    next();
  })(req, res, next);
};
module.exports = { authMiddleware, adminMiddleware };
