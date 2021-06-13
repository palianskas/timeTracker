import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:time_tracker/blocs/timestampBloc/timestampsEvent.dart';
import 'package:time_tracker/blocs/timestampBloc/timestampsState.dart';
import 'package:time_tracker/timestampsRepository/timestampsRepository.dart';

class TimestampsBloc extends Bloc<TimestampsEvent, TimestampsState> {
  final TimestampsRepository _timestampsRepository;
  StreamSubscription? _timestampsSubscription;

  TimestampsBloc(this._timestampsRepository) : super(TimestampsLoading());

  @override
  Stream<TimestampsState> mapEventToState(TimestampsEvent event) async* {
    if (event is LoadTimestamps) {
      yield* _mapLoadTimestampsToState();
    } else if (event is TimestampsUpdated) {
      yield* _mapTimestampsUpdateToState(event);
    } else {
      if (event is AddTimestamp) {
        yield* _mapAddTimestampToState(event);
      } else if (event is UpdateTimestamp) {
        yield* _mapUpdateTimestampToState(event);
      } else if (event is DeleteTimestamp) {
        yield* _mapDeleteTimestampToState(event);
      }

      yield* _mapLoadTimestampsToState();
    }
  }

  Stream<TimestampsState> _mapLoadTimestampsToState() async* {
    _timestampsSubscription?.cancel();
    _timestampsSubscription = _timestampsRepository.timestamps().listen(
      (timestamps) {
        return add(TimestampsUpdated(timestamps));
      },
    );
  }

  Stream<TimestampsState> _mapAddTimestampToState(AddTimestamp event) async* {
    _timestampsRepository.addNewTimestamp(event.timestamp);
  }

  Stream<TimestampsState> _mapUpdateTimestampToState(
      UpdateTimestamp event) async* {
    _timestampsRepository.updateTimestamp(event.updatedTimestamp);
  }

  Stream<TimestampsState> _mapDeleteTimestampToState(
      DeleteTimestamp event) async* {
    _timestampsRepository.deleteTimestamp(event.timestamp);
  }

  Stream<TimestampsState> _mapTimestampsUpdateToState(
      TimestampsUpdated event) async* {
    yield TimestampsLoaded(event.timestamps);
  }

  @override
  Future<void> close() {
    _timestampsSubscription?.cancel();
    return super.close();
  }
}
