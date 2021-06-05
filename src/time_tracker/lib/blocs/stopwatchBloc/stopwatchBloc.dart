import 'dart:async';

class StopwatchBloc {
  final StreamController<int> _controller = StreamController<int>();

  Timer? _timer;
  final Duration _interval = Duration(seconds: 1);

  int _ticks = 0;

  void _onTick(_) {
    _controller.add(_ticks++);
  }

  void start() {
    _timer = Timer.periodic(_interval, _onTick);
  }

  void stop() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void reset() {
    _ticks = 0;
    _controller.add(_ticks);
  }

  String _formatTimeValue(String value) {
    return value.length > 1 ? value : '0' + value;
  }

  Iterable<String> format(int ticks) {
    return ['${ticks ~/ 3600}', '${ticks % 3600 ~/ 60}', '${ticks % 60}']
        .map((value) => _formatTimeValue(value));
  }

  Stream<int> get stream {
    return _controller.stream;
  }
}
