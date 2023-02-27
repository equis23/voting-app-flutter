const path = require('path');
const express = require('express');
const http = require('http');
const { Server } = require('socket.io');
const Band = require('./models/band');
const Bands = require('./models/bands');

const bands = new Bands();
[
  new Band('Widget A'),
  new Band('Gizmo B'),
  new Band('Thingamajig C'),
  new Band('Doohickey D'),
  new Band('Whatchamacallit E'),
  new Band('Doodad F'),
  new Band('Gadget G'),
  new Band('Contraption H'),
  new Band('Apparatus I'),
  new Band('Gizmo J'),
].forEach((band) => bands.addBand(band));

const app = express();
const server = http.createServer(app);
const io = new Server(server);
const port = 8080;

io.on('connection', (socket) => {
  socket.emit('server:init', bands);

  socket.on('mobile-client:beep', (payload) => {
    socket.broadcast.emit('server:beep', payload);
  });
});

app.use(express.static(path.join(__dirname, '/public')));

server.listen(port, (err) => {
  if (err) console.log(err.message);
  console.log(`server up and running at http://localhost:${port}`);
});
