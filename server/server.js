const express = require("express");
const app = express();
const socketIO = require("./socketIO");
const LocationRouter = require("./routers/Location.router");
const AuthenRouter = require("./routers/Authen.router");
const UserRouter = require("./routers/User.router");
const CompanyRouter = require("./routers/Company.router");
const morgan = require("morgan");
const cors = require("cors");
require("dotenv").config();
const PORT = process.env.PORT;

const Atlas = process.env.Atlas;

const bodyParser = require("body-parser");
app.use(cors());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(morgan("tiny"));

//connect database
require("./database");

app.use(LocationRouter);

app.use(UserRouter);

app.use(AuthenRouter);

app.use(CompanyRouter);

const server = app.listen(PORT, () => {
  console.log("Server is running in port:" + PORT);
});

socketIO(server);

module.exports = app;
