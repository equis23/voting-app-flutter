// ignore_for_file: library_prefixes
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { online, offline, connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late IO.Socket _socket;

  SocketService() {
    _initConfig();
  }

  ServerStatus get serverStatus {
    return _serverStatus;
  }

  IO.Socket get socket {
    return _socket;
  }

  void _initConfig() {
    _socket = IO.io(
      'http://10.0.2.2:8080',
      IO.OptionBuilder().setTransports(['websocket']).build(),
    );

    socket.on('connect', (_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

    socket.on('disconnect', (_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });
  }
}
