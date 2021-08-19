import io from "socket.io-client";
let socket;
const ENDPOINT = "http://localhost:908";
// const ENDPOINT = "https://tiepdan.herokuapp.com/";

export const initiateSocket = () => {
    socket = io.connect(ENDPOINT, { reconnection: true });
    console.log(`Connecting socket... ${socket}`);
  };

  export const disconnectSocket = () => {
    console.log("Disconnecting socket...");
    if (socket) socket.disconnect();
  };

  


  export const refeshIO = () => {
    if (socket) socket.emit("refresh");
  };

  export const fetch = () => {};
  
