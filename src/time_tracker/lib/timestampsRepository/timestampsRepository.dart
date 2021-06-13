import 'dart:async';

import 'package:objectdb/objectdb.dart';
import 'package:time_tracker/database/database.dart';
import 'package:time_tracker/models/timestamp.dart';

class TimestampsRepository {
  Future<ObjectId> addNewTimestamp(Timestamp timestamp) async {
    return (await Database.singleton).insert(timestamp.toMap());
  }

  Future<int> deleteTimestamp(Timestamp timestamp) async {
    return (await Database.singleton).delete({'id': timestamp.id});
  }

  Stream<List<Timestamp>> timestamps() {
    return Stream.fromFuture(_getTimestamps());
  }

  Future<int> updateTimestamp(Timestamp timestamp) async {
    return (await Database.singleton)
        .update({'id': timestamp.id}, timestamp.toMap());
  }

  Future<List<Timestamp>> _getTimestamps() async {
    List<Map> maps = await (await Database.singleton).getAll();

    return maps.map((map) => Timestamp.fromMap(map)).toList();
  }
}
