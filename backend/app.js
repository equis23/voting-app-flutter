const path = require('path');
const express = require('express');
const http = require('http');
const { Server } = require('socket.io');
const Band = require('./models/band');
const Bands = require('./models/bands');

const bands = new Bands();
const names = [
  'Widget A',
  'Gizmo B',
  'Thingamajig C',
  'Doohickey D',
  'Whatchamacallit E',
  'Doodad F',
  'Gadget G',
  'Contraption H',
  'Apparatus I',
  'Gizmo J',
  'Rayados',
];
names.forEach((name) => bands.addBand(new Band(name)));

const app = express();
const server = http.createServer(app);
const io = new Server(server);
const port = 8080;

io.on('connection', (socket) => {
  socket.emit('server:update', bands.getBands());

  socket.on('mobile-client:beep', (payload) => {
    socket.broadcast.emit('server:beep', payload);
  });

  socket.on('client:vote', (payload) => {
    console.log(payload.id);
    console.table(bands.voteBand(payload.id));
    io.emit('server:update', bands.getBands());
  });

  socket.on('client:new-band', (payload) => {
    bands.addBand(new Band(payload.name));
    console.table(bands.voteBand(payload.id));
    io.emit('server:update', bands.getBands());
  });

  socket.on('client:delete-band', (payload) => {
    bands.deleteBand(payload.id);
    console.table(bands.getBands);
    io.emit('server:update');
  });
});

app.use(express.static(path.join(__dirname, '/public')));

server.listen(port, (err) => {
  if (err) console.log(err.message);
  console.log(`server up and running at http://localhost:${port}`);
});
