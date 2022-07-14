import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'package:sios_app/env.dart';
import 'package:sios_app/models/models.dart';
import 'package:sios_app/services/services.dart';

enum ServerStatus { online, offline, connecting }

class SocketProvider extends ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;

  late io.Socket _socket;
  final baseUrl = Env.baseUrl;
  late dynamic services = [];

  ServerStatus get serverStatus => _serverStatus;
  io.Socket get socket => _socket;

  Function get emit => _socket.emit;

  void connect() async {
    final token = await AuthService.getToken();

    _socket = io.io(
      baseUrl,

      io.OptionBuilder()
          .setTransports(['websocket'])
          .enableForceNew()
          .setQuery({'accessToken': 'Bearer $token'})
          .build(),
    );

    _socket.on('connect', (_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });

    _socket.on('services-list', (servicios) {
      services = servicios;
      notifyListeners();
    });
  }

  void disconnect() {
    _socket.disconnect();
  }

  void startService(String toUserId, String fromUserId, String serviceId) {
    _socket.emit('start', {
      "to": toUserId,
      "from": fromUserId,
      "service": serviceId,
    });
  }

  void finalizeService(String toUserId, String fromUserId, Service service) {
    // print({
    //   'to': toUserId,
    //   'from': fromUserId,
    //   'service': {
    //     '_id': service.id,
    //     'feedback': service.feedback,
    //     'description': service.description,
    //     'solution': service.solution,
    //     'device': service.device
    //   }
    // });

    _socket.emit('finalize-service', {
      'to': toUserId,
      'from': fromUserId,
      'service': {
        '_id': service.id,
        'feedback': service.feedback,
        'description': service.description,
        'solution': service.solution,
        'device': service.device,
      }
    });

    // print("SENT TO SOCKET");
  }
}
