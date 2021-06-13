const express = require("express");
const router = express.Router();
const mongoose = require("mongoose");
const Location = require("../models/Location.model");
const RequireLogin = require("../middlewares/RequireLogin");
require("dotenv").config();
// var multer = require("multer");
var fs = require("fs");
const { db } = require("../models/Location.model");
// require("../database");

// const storage = multer.diskStorage({});

router.get("/", (req, res) => {
  res.send("Hello Wellcome To TrackLocationRealTime API");
}); //req = request (đẩy lên DB) -- res = response (lấy dữ liệu về từ DB)

router.get("/alllocation", RequireLogin, (req, res) => {
  Location.collection
    .find({}, { projection: { _id: 0, latitude: 1, longitude: 1 } })
    .toArray(function (err, Locations) {
      if (err) throw err;
      res.json({ Locations });
    });
});

router.get("/location/:id", RequireLogin, (req, res) => {
  // console.log(req.body.time + "T00:00:00.000+00:00");
  Location.find({
    postedBy: req.params.id,
    time: req.body.time + "T00:00:00.000+00:00",
  })
    .populate("-postedBy")
    .then((Locations) => {
      res.json({ Locations });
    })
    .catch((err) => {
      console.log(err);
      return res.status(404).json({ error: "loi" });
    });
});

router.post("/updatelocation", RequireLogin, (req, res) => {
  const { latitude, longitude } = req.body;
  if (!latitude || !longitude) {
    return res.status(422).json({ error: "Hãy điền đầy đủ thông tin" });
  }
  const location = new Location({
    latitude,
    longitude,
    postedBy: req.user,
  });
  location
    .save()
    .then((result) => {
      res.json({ location: result });
    })
    .catch((err) => {
      console.log(err);
    });
});

module.exports = router;
