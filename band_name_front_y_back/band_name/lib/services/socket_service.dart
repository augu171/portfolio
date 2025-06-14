import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket? _socket;

  ServerStatus get serverStatus => _serverStatus;

  IO.Socket? get socket => _socket;
  Function get emit => _socket!.emit;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    // Dart client
    _socket = IO.io('https://flutter-sockets-sv.herokuapp.com/',
        // 'http://10.0.10.36:3000/'
        {
          'transports': ['websocket'],
          'autoConnect': true
        });

    _socket!.on('connect', (_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket!.on('disconnect', (_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    // _socket!.on('nuevo-mensaje', (payload) {
    //   print('Nuevo mensaje: $payload');
    // });
  }
}
