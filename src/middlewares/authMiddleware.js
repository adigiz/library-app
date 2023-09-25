const passport = require("../lib/passport");
const authMiddleware = passport.authenticate("jwt", { session: false });

module.exports = authMiddleware;
