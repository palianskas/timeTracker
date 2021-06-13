import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:time_tracker/blocs/stopwatchBloc/stopwatchBloc.dart';
import 'package:time_tracker/models/timestamp.dart';
import 'package:time_tracker/widgets/stopwatch/stopwatchInner.dart';

class Stopwatch extends StatelessWidget {
  final Timestamp timestamp;
  final Function onSave;
  final Function onDelete;

  Stopwatch(this.timestamp, this.onSave, this.onDelete);

  @override
  Widget build(BuildContext context) {
    return HookBuilder(
      builder: (context) {
        final stopwatch = useMemoized(() => StopwatchBloc(timestamp, onSave));

        return StreamBuilder(
            stream: stopwatch.stream,
            builder: (context, snapshot) {
              return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    onDelete(stopwatch.timestamp);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('${stopwatch.timestamp.name} deleted')));
                  },
                  background: Container(color: Colors.red.shade400),
                  child: StopwatchInner(stopwatch.timestamp, stopwatch.start,
                      stopwatch.stop, stopwatch.reset));
            });
      },
    );
  }
}
