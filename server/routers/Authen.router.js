const express = require("express");
const router = express.Router();
const bcrypt = require("bcryptjs");
const User = require("../models/User.model");
const Company = require("../models/Company.model");
const jwt = require("jsonwebtoken");
const RequireLogin = require("../middlewares/RequireLogin");
const RequireCompany = require("../middlewares/RequireCompany");
require("dotenv").config();

// router.get("/", (req, res) => {
//   res.send("Hello Wellcome To My Word");
// }); //req = request (đẩy lên DB) -- res = response (lấy dữ liệu về từ DB)

router.post("/user/signup", RequireCompany, (req, res) => {
  const { name, email, password, phone, role } = req.body;
  if (!email || !password || !name || !phone || !role) {
    return res.status(422).json({ error: "Chưa điền đầy đủ thông tin!" });
  }
  User.findOne({ phone: phone })
    .then((savedUser) => {
      if (savedUser) {
        return res.status(422).json({ error: "Tài khoản này đã tồn tại!" });
      }
      bcrypt.hash(password, 12).then((hashedpassword) => {
        const user = new User({
          email,
          phone,
          password: hashedpassword,
          name,
          role,
          company: req.company,
        });

        user
          .save()
          .then((user) => {
            res.json({ message: "Đăng ký thành công" });
          })
          .catch((err) => {
            console.log(err);
          });
      });
    })
    .catch((err) => {
      console.log(err);
    });
});

router.post("/user/signin", (req, res) => {
  const { phone, password } = req.body;
  if (!phone || !password) {
    return res.status(422).json({ error: "Hãy điền đầy đủ thông tin" });
  }
  User.findOne({ phone: phone }).then((savedUser) => {
    if (!savedUser) {
      return res.status(422).json({ error: "Sai tài khoản" });
    }
    bcrypt
      .compare(password, savedUser.password)
      .then((doMatch) => {
        if (doMatch) {
          const token = jwt.sign({ user: savedUser}, process.env.JWT_KEY);
          const {
            _id,
            name,
            phone,
            email,
            // followers,
            // following,
            avatar,
          } = savedUser;
          res.json({ token });
        } else {
          return res.status(422).json({ error: "Sai mật khẩu" });
        }
      })
      .catch((err) => {
        console.log(err);
      });
  });
});

router.post("/user/me/logout", RequireLogin, async (req, res) => {
  try {
    req.user.tokens = req.user.tokens.filter((token) => {
      return token.token != req.token;
    });
    await req.user.save();
    res.json("Đăng xuất thành công !");
  } catch (error) {
    res.status(500).json("Đăng xuất không thành công!");
  }
});

module.exports = router;
