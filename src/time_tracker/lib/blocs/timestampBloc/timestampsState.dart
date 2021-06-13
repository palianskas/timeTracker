import 'package:equatable/equatable.dart';

import 'package:time_tracker/models/timestamp.dart';

abstract class TimestampsState extends Equatable {
  const TimestampsState();

  @override
  List<Object> get props => [];
}

class TimestampsLoading extends TimestampsState {}

class TimestampsLoaded extends TimestampsState {
  final List<Timestamp> timestamps;

  const TimestampsLoaded([this.timestamps = const []]);

  @override
  List<Object> get props => [timestamps];

  @override
  String toString() => 'TimestampsLoaded { timestamps: $timestamps }';
}

class TimestampsNotLoaded extends TimestampsState {}
