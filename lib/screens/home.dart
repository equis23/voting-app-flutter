import 'package:flutter/material.dart';
import 'package:voting_app/models/band.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band.fromMap({"id": '1', "name": "Widget A", "votes": 42}),
    Band.fromMap({"id": '2', "name": "Gizmo B", "votes": 21}),
    Band.fromMap({"id": '3', "name": "Thingamajig C", "votes": 7}),
    Band.fromMap({"id": '4', "name": "Doohickey D", "votes": 15}),
    Band.fromMap({"id": '5', "name": "Whatchamacallit E", "votes": 3}),
    Band.fromMap({"id": '6', "name": "Doodad F", "votes": 27}),
    Band.fromMap({"id": '7', "name": "Gadget G", "votes": 11}),
    Band.fromMap({"id": '8', "name": "Contraption H", "votes": 8}),
    Band.fromMap({"id": '9', "name": "Apparatus I", "votes": 36}),
    Band.fromMap({"id": '10', "name": "Gizmo J", "votes": 19})
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'home page',
        ),
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
          band.vote.toString(),
        ),
        onTap: () {
          setState(() {
            band.vote += 1;
          });
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
        setState(() {
          bands.removeAt(index);
        });
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
}

void addNewBand(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('add new band'),
        content: const Text(
          'here goes the band',
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
              Navigator.of(context).pop();
            },
            child: const Text('ok'),
          ),
        ],
      );
    },
  );
}
