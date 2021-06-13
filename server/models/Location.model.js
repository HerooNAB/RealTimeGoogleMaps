const mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema.Types;

date = new Date("2021-06-12T00:00:00.000+00:00");
year = date.getFullYear();
month = date.getMonth() + 1;
dt = date.getDate();

if (dt < 10) {
  dt = "0" + dt;
}
if (month < 10) {
  month = "0" + month;
}

var time = year + "-" + month + "-" + dt;

// console.log(time);

const LocationSchema = new mongoose.Schema(
  {
    //Vĩ Độ
    latitude: {
      type: String,
      required: true,
    },
    //Kinh Độ
    longitude: {
      type: String,
      required: true,
    },
    postedBy: {
      type: ObjectId,
      ref: "User",
    },
    time: {
      type: Date,
      default: time,
    },
  }
  // { timestamps: time }
);

const Location = mongoose.model("Location", LocationSchema);

module.exports = Location;
