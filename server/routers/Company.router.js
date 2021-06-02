const express = require("express");
const router = express.Router();
const bcrypt = require("bcryptjs");
const User = require("../models/User.model");
const Company = require("../models/Company.model");
const jwt = require("jsonwebtoken");
const RequireLogin = require("../middlewares/RequireLogin");
require("dotenv").config();

router.post("/company/signup", (req, res) => {
  const { name, email, web, phone } = req.body;
  if (!email || !web || !name || !phone) {
    return res.status(422).json({ error: "Chưa điền đầy đủ thông tin!" });
  }
  Company.findOne({ phone: phone })
    .then((savedUser) => {
      if (savedUser) {
        return res.status(422).json({ error: "Công ty đã đăng ký!" });
      }
      const company = new Company({
        email,
        phone,
        web,
        name,
        // avatar,
      });
      company
        .save()
        .then((company) => {
          res.json({ message: "Đăng ký công ty thành công" });
        })
        .catch((err) => {
          console.log(err);
        });
    })
    .catch((err) => {
      console.log(err);
    });
});

router.post("/company/signin", (req, res) => {
  const { name } = req.body;
  if (!name) {
    return res.status(422).json({ error: "Hãy điền đầy đủ thông tin" });
  }
  Company.findOne({ name: name }).then((savedCompany) => {
    if (!savedCompany) {
      return res.status(422).json({ error: "Sai tài khoản" });
    }
    const token = jwt.sign({ _id: savedCompany._id }, process.env.JWT_KEY);

    const { _id, name, phone, email, web } = savedCompany;
    res.json({ token });
  });
});

router.get("/company/:id", (req, res) => {
  Company.find({ _id: req.params.id }).then((Company) => {
    res.json({ Company });
  });
});

router.get("/company/listuser/:id", RequireLogin, (req, res) => {
  User.find({ company: req.params.id, role: "user" })
    .populate("-company", "-role")
    .then((listUser) => {
      res.json({ listUser });
    })
    .catch((err) => {
      console.log(err);
      return res.status(404).json({ error: "loi" });
    });
});

module.exports = router;
