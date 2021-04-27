const mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema.Types;
const LocationSchema = new mongoose.Schema({
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
});

const Location = mongoose.model("Location", LocationSchema);

module.exports = Location;
