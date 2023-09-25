const passport = require("passport");
const { authenticate } = require("../repositories/userRepository");
const JwtStrategy = require("passport-jwt").Strategy;
const ExtractJwt = require("passport-jwt").ExtractJwt;

const options = {
  jwtFromRequest: ExtractJwt.fromHeader("authorization"),
  secretOrKey: process.env.SECRET_KEY,
};

passport.use(new JwtStrategy(options, authenticate));

module.exports = passport;
