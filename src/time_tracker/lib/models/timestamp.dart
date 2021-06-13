import 'package:uuid/uuid.dart';

class Timestamp {
  late String _id;
  late String _name;
  late int _value;
  late DateTime _createdAt;

  static Uuid _uuid = new Uuid();

  Timestamp(this._name, {int? value, String? id, DateTime? createdAt}) {
    _id = id != null ? id : _uuid.v4();
    _value = value != null ? value : 0;
    _createdAt = createdAt != null ? createdAt : DateTime.now().toUtc();
  }

  int get value => _value;
  String get name => _name;
  String get id => _id;

  update(int newValue) {
    _value = newValue;
  }

  reset() {
    _value = 0;
  }

  add(int value) {
    _value += value;
  }

  Map toMap() {
    return {
      'id': _id,
      'name': _name,
      'value': _value,
      'createdAt': _createdAt.toUtc().toIso8601String(),
    };
  }

  static Timestamp fromMap(Map map) {
    return new Timestamp(map['name'],
        value: map['value'],
        id: map['id'],
        createdAt: DateTime.tryParse(map['createdAt']));
  }
}
