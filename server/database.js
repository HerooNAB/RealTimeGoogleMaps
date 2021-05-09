// const mongoose = require("mongoose");
// require("dotenv").config();

// const address = process.env.DB;
// const atlas = process.env.Atlas;

// mongoose.connect(
//   atlas,
//   {
//     useNewUrlParser: true,
//     useCreateIndex: true,
//     useFindAndModify: true,
//     useUnifiedTopology: true,
//   },
//   () => console.log("Database connected " + address)
// );

const mongoose = require("mongoose");
require("dotenv").config();

const address = process.env.DB;

mongoose.connect(address, { useNewUrlParser: true }, () =>
  console.log("Database connected " + address)
);
