import 'package:flutter/material.dart';

class StopwatchInner extends StatelessWidget {
  final Iterable<String> values;
  final Function onStart;
  final Function onStop;
  final Function onReset;

  StopwatchInner(this.values, this.onStart, this.onStop, this.onReset);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
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
    );
  }
}
