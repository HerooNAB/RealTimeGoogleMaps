const jwt = require("jsonwebtoken");
require("dotenv").config();
const Company = require("../models/Company.model");
module.exports = (req, res, next) => {
  const { authorization } = req.headers;
  //authorization === Bearer ewefwegwrherhe
  if (!authorization) {
    return res.status(401).json({ error: "Bạn chưa có công ty" });
  }
  const token = authorization.replace("Bearer ", "");

  jwt.verify(token, process.env.JWT_KEY, (err, payload) => {
    if (err) {
      return res.status(401).json({ error: "Bạn chưa có công ty" });
    }

    const { _id } = payload;
    Company.findById(_id).then((companydata) => {
      req.company = companydata;
      next();
    });
  });
};
