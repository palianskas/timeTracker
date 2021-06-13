import 'package:flutter/material.dart';
import 'package:time_tracker/blocs/stopwatchBloc/stopwatchBloc.dart';
import 'package:time_tracker/models/timestamp.dart';

class StopwatchInner extends StatelessWidget {
  final Timestamp timestamp;
  final Function onStart;
  final Function onStop;
  final Function onReset;

  StopwatchInner(this.timestamp, this.onStart, this.onStop, this.onReset);

  @override
  Widget build(BuildContext context) {
    Iterable<String> values = StopwatchBloc.format(this.timestamp.value);

    return Center(
        child: Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(children: [
              Text(timestamp.name, style: TextStyle(fontSize: 24)),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        onStart();
                      },
                      child: Text('Start'),
                    ),
                  ),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        onReset();
                      },
                      child: Text('Reset'),
                    ),
                  ),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        onStop();
                      },
                      child: Text('Stop'),
                    ),
                  ),
                ],
              ),
              Text(
                '${values.elementAt(0)}:${values.elementAt(1)}:${values.elementAt(2)}',
                style: const TextStyle(fontSize: 36),
              )
            ]),
          )),
    ));
  }
}
