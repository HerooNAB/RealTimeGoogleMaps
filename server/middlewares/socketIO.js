const socket = require("socket.io");
const Location = require('../models/Location.model');
require("dotenv").config();

const socketIO = (server) => {
  const io = socket(server,{
    cors: {
      origin: "http://localhost:3000",
  }
  });
  io.on("connection", (socket) => {
    console.log(`${socket.id} connected`);

    socket.on("disconnect", () => {
      console.log(`${socket.id} disconnected`);
    });

    socket.on("refresh", async () => {
      console.log("alo alo refresh"),
        socket.broadcast.emit("refresh-done"),
        socket.emit("refresh-done");
    });
  });
  
};

module.exports = socketIO;
