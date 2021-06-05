import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:time_tracker/blocs/stopwatchBloc/stopwatchBloc.dart';
import 'package:time_tracker/widgets/stopwatch/stopwatchInner.dart';

class Stopwatch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HookBuilder(
      builder: (context) {
        final stopwatch = useMemoized(() => StopwatchBloc());

        return StreamBuilder(
            stream: stopwatch.stream,
            builder: (context, snapshot) => StopwatchInner(
                stopwatch.format((snapshot.data ?? 0) as int),
                stopwatch.start,
                stopwatch.stop,
                stopwatch.reset));
      },
    );
  }
}
