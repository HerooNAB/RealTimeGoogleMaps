const express = require("express");
const router = express.Router();

const RequireLogin = require("../middlewares/RequireLogin");
require("dotenv").config();

router.get("/user/me", RequireLogin, (req, res) => {
  console.log(req.user);
  res.send(req.user);
});

module.exports = router;
