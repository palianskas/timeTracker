import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:objectdb/objectdb.dart';
import 'package:objectdb/src/objectdb_storage_filesystem.dart';

class Database {
  ObjectDB? _objectDatabase;
  static Database? _instance;

  static Future<void> _init() async {
    _instance = new Database();

    _instance!._objectDatabase = ObjectDB(FileSystemStorage(
        (await getApplicationDocumentsDirectory()).path + '/database.db'));
  }

  static Future<Database> get singleton async {
    if (_instance == null) {
      await _init();
    }

    return _instance!;
  }

  Future<Map> findById(String id) async {
    return _objectDatabase!.first({'id': id});
  }

  Future<List<Map>> findByName(String name) async {
    return await _objectDatabase!.find({'name': name});
  }

  Future<List<Map>> find(Map query) async {
    return await _objectDatabase!.find(query);
  }

  Future<ObjectId?> insert(Map document) async {
    return _objectDatabase!.insert(document);
  }

  Future<int> update(Map query, Map changes, {bool replace = false}) async {
    return await _objectDatabase!.update(query, changes, replace);
  }

  Future<int> delete(Map query) async {
    return await _objectDatabase!.remove(query);
  }
}
