let AuthController = require('../auth/auth.controller');

module.exports = function (io, socket) {

    // socket.emit('reconnect', AuthController.Socket.reconnect(socket.id));

    socket.on('authenticate', (data) => AuthController.Socket.authenticate(socket, data));

    socket.on('join-consumer', (data) => AuthController.Socket.joinConsumer(socket, data));

    socket.on('join-store', (data) => AuthController.Socket.joinStore(socket, data));

    socket.on("disconnect", (data) => AuthController.Socket.disconnect(io, socket, data));

    socket.on("disconnectChat", (data) => AuthController.Socket.disconnect(io, socket, data));

};