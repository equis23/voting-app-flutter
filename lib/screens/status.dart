import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_app/services/socket_service.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'home');
            },
            icon: const Icon(
              Icons.home,
            ),
          ),
        ],
      ),
      body: Center(
        child: Text('${socketService.serverStatus}'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.record_voice_over),
        onPressed: () {
          socketService.socket.emit('mobile-client:beep', {'message': 'beep'});
        },
      ),
    );
  }
}
