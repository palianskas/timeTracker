import 'dart:async';

import 'package:time_tracker/models/timestamp.dart';

class StopwatchBloc {
  final StreamController<Timestamp> _controller = StreamController<Timestamp>();
  final Function onSave;

  Timer? _timer;
  final Duration _interval = Duration(seconds: 1);

  late Timestamp timestamp;

  StopwatchBloc(this.timestamp, this.onSave) {
    _controller.add(this.timestamp);
  }

  void _saveToRepo() {
    onSave(timestamp);
  }

  void _onTick(_) {
    this.timestamp.add(1);

    _controller.add(this.timestamp);

    if (this.timestamp.value % 60 == 0) {
      _saveToRepo();
    }
  }

  void start() {
    _timer = _timer != null && _timer!.isActive
        ? _timer
        : Timer.periodic(_interval, _onTick);
  }

  void stop({bool save = true}) {
    if (_timer != null) {
      _timer!.cancel();
    }

    if (save) {
      _saveToRepo();
    }
  }

  void reset() {
    this.timestamp.reset();
    _controller.add(this.timestamp);
    _saveToRepo();
  }

  Stream<Timestamp> get stream {
    return _controller.stream;
  }

  static String _formatTimeValue(String value) {
    return value.length > 1 ? value : '0' + value;
  }

  static Iterable<String> format(int ticks) {
    return ['${ticks ~/ 3600}', '${ticks % 3600 ~/ 60}', '${ticks % 60}']
        .map((value) => _formatTimeValue(value));
  }
}
