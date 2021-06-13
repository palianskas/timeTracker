import 'package:equatable/equatable.dart';
import 'package:time_tracker/models/timestamp.dart';

abstract class TimestampsEvent extends Equatable {
  const TimestampsEvent();

  @override
  List<Object> get props => [];
}

class LoadTimestamps extends TimestampsEvent {}

class AddTimestamp extends TimestampsEvent {
  final Timestamp timestamp;

  const AddTimestamp(this.timestamp);

  @override
  List<Object> get props => [timestamp];

  @override
  String toString() => 'AddTimestamp { timestamp: $timestamp }';
}

class UpdateTimestamp extends TimestampsEvent {
  final Timestamp updatedTimestamp;

  const UpdateTimestamp(this.updatedTimestamp);

  @override
  List<Object> get props => [updatedTimestamp];

  @override
  String toString() =>
      'UpdateTimestamp { updatedTimestamp: $updatedTimestamp }';
}

class DeleteTimestamp extends TimestampsEvent {
  final Timestamp timestamp;

  const DeleteTimestamp(this.timestamp);

  @override
  List<Object> get props => [timestamp];

  @override
  String toString() => 'DeleteTimestamp { timestamp: $timestamp }';
}

class TimestampsUpdated extends TimestampsEvent {
  final List<Timestamp> timestamps;

  const TimestampsUpdated(this.timestamps);

  @override
  List<Object> get props => [timestamps];
}
