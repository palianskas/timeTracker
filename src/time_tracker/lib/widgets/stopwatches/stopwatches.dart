import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:time_tracker/blocs/timestampBloc/timestampsBloc.dart';
import 'package:time_tracker/blocs/timestampBloc/timestampsEvent.dart';
import 'package:time_tracker/blocs/timestampBloc/timestampsState.dart';
import 'package:time_tracker/widgets/stopwatch/stopwatchController.dart';

class Stopwatches extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimestampsBloc, TimestampsState>(
      builder: (context, state) {
        if (state is TimestampsLoading) {
          return CircularProgressIndicator();
        } else if (state is TimestampsLoaded && state.timestamps.length > 0) {
          final timestamps = state.timestamps;
          final onSave =
              (timestamp) => BlocProvider.of<TimestampsBloc>(context).add(
                    UpdateTimestamp(timestamp),
                  );
          final onDelete =
              (timestamp) => BlocProvider.of<TimestampsBloc>(context).add(
                    DeleteTimestamp(timestamp),
                  );

          return ListView.builder(
              itemCount: timestamps.length,
              itemBuilder: (context, index) {
                return Stopwatch(timestamps[index], onSave, onDelete);
              });
        }

        return Center(child: Text('No timers added'));
      },
    );
  }
}
