import 'package:flutter/material.dart';
import 'package:voting_app/models/band.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band.fromMap({"id": 1, "name": "Widget A", "votes": 42}),
    Band.fromMap({"id": 2, "name": "Gizmo B", "votes": 21}),
    Band.fromMap({"id": 3, "name": "Thingamajig C", "votes": 7}),
    Band.fromMap({"id": 4, "name": "Doohickey D", "votes": 15}),
    Band.fromMap({"id": 5, "name": "Whatchamacallit E", "votes": 3}),
    Band.fromMap({"id": 6, "name": "Doodad F", "votes": 27}),
    Band.fromMap({"id": 7, "name": "Gadget G", "votes": 11}),
    Band.fromMap({"id": 8, "name": "Contraption H", "votes": 8}),
    Band.fromMap({"id": 9, "name": "Apparatus I", "votes": 36}),
    Band.fromMap({"id": 10, "name": "Gizmo J", "votes": 19})
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'home page',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) {
          return _bandTile(index);
        },
      ),
    );
  }

  Widget _bandTile(int index) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(
          bands.elementAt(index).name.substring(0, 2),
        ),
      ),
    );
  }
}
