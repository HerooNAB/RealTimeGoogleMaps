// const Post = require("../models/Post.model");
const socket = require("socket.io");
// const RequireLogin = require("../middleware/requireLogin");
const jwt = require("jsonwebtoken");
require("dotenv").config();

const socketIO = (server) => {
  const io = socket(server);
  io.on("connection", (socket) => {
    console.log(`${socket.id} connected`);

    socket.on("disconnect", () => {
      console.log(`${socket.id} disconnected`);
    });
  });
};

module.exports = socketIO;
