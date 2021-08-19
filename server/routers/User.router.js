const express = require("express");
const router = express.Router();
const User = require("../models/User.model");
const RequireLogin = require("../middlewares/RequireLogin");
require("dotenv").config();

router.get("/user/me", RequireLogin, (req, res) => {
  console.log(req.user);
  res.send(req.user);
});

router.get("/user/:id",(req, res) => {
  User.find({
    _id: req.params.id,
  })
    .then((user) => {
      res.json(user);
    })
    .catch((err) => {
      console.log(err);
      return res.status(404).json({ error: "loi" });
    });
});

module.exports = router;
