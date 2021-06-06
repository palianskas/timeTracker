import 'package:objectdb/objectdb.dart';
import 'package:time_tracker/database/database.dart';
import 'package:time_tracker/models/timestamp.dart';

class DatabaseBloc {
  late final Database _database;
  static DatabaseBloc? _instance;

  static Future<void> _init() async {
    _instance = new DatabaseBloc();

    _instance!._database = await Database.singleton;
  }

  static Future<void> save(Timestamp timestamp) async {
    if (_instance == null) {
      await _init();
    }

    if (timestamp.value > 0) {
      _instance!.insert(timestamp);
    } else {
      _instance!.update(timestamp);
    }
  }

  Future<List<Timestamp>> getAll() async {
    return (await _database.getAll())
        .map((item) => Timestamp.fromMap(item))
        .toList();
  }

  Future<Timestamp> findById(String id) async {
    return Timestamp.fromMap((await _database.findById(id)));
  }

  Future<List<Timestamp>> findByName(String name) async {
    return (await _database.findByName(name))
        .map((item) => Timestamp.fromMap(item))
        .toList();
  }

  Future<ObjectId> insert(Timestamp timestamp) async {
    return _database.insert(timestamp.toMap());
  }

  Future<int> update(Timestamp timestamp) async {
    Map map = timestamp.toMap();

    return _database.update({'_id': map['id']}, map);
  }

  Future<int> delete(Timestamp timestamp) async {
    Map map = timestamp.toMap();

    return _database.delete({'_id': map['id']});
  }

  Future<int> deleteById(String id) async {
    return _database.delete({'_id': id});
  }
}
