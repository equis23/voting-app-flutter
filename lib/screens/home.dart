import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_app/models/band.dart';
import 'package:voting_app/services/socket_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [];

  @override
  void initState() {
    final SocketService socketServer =
        Provider.of<SocketService>(context, listen: false);
    socketServer.socket.on('server:update', _handlePayload);
    super.initState();
  }

  void _handlePayload(dynamic payload) {
    setState(() {
      // List<dynamic> data = payload;
      // bands = data.map((band) => Band.fromMap(band)).toList();
      bands = (payload as List).map((band) => Band.fromMap(band)).toList();
    });
  }

  @override
  void dispose() {
    final SocketService socketService =
        Provider.of<SocketService>(context, listen: false);
    socketService.socket.off('server:init');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SocketService socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'home page',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        actions: [
          Container(
            child: (socketService.serverStatus == ServerStatus.online)
                ? const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.highlight_off,
                    color: Colors.red,
                  ),
            padding: const EdgeInsets.only(
              right: 10,
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) {
          final band = bands.elementAt(index);
          return _bandTile(band, index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          addNewBand(context);
        },
      ),
    );
  }

  Widget _bandTile(Band band, int index) {
    final SocketService socketService =
        Provider.of<SocketService>(context, listen: false);

    return Dismissible(
      key: Key(band.id),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            band.name.substring(0, 2),
          ),
        ),
        title: Text(
          band.name,
        ),
        trailing: Text(
          band.votes.toString(),
        ),
        onTap: () {
          socketService.socket.emit('client:vote', {'id': band.id});
        },
      ),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(
          left: 10,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        socketService.socket.emit('client:delete-band', {'id': band.id});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${band.name} deleted',
            ),
            duration: const Duration(seconds: 1),
          ),
        );
      },
    );
  }

  void addNewBand(BuildContext context) {
    final SocketService socketService =
        Provider.of<SocketService>(context, listen: false);
    final TextEditingController bandName = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('add new band'),
          content: TextField(
            controller: bandName,
            decoration: const InputDecoration(
              hintText: 'enter here new band\'s name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'cancel',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                if (bandName.text.length > 1) {
                  socketService.socket
                      .emit('client:new-band', {'name': bandName.text});
                }
                Navigator.of(context).pop();
              },
              child: const Text('ok'),
            ),
          ],
        );
      },
    );
  }
}
