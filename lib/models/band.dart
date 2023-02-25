import 'package:uuid/uuid.dart';

class Band {
  String id;
  String name;
  int vote;

  Band({
    required this.id,
    required this.name,
    required this.vote,
  });

  factory Band.fromMap(Map<String, dynamic> obj) {
    return Band(
      id: obj.containsKey('id') ? obj['id'] : const Uuid().v4(),
      name: obj.containsKey('name') ? obj['name'] : 'no name',
      vote: obj.containsKey('vote') ? obj['vote'] : 0,
    );
  }
}
