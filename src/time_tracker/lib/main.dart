import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracker/blocs/timestampBloc/timestampsBloc.dart';
import 'package:time_tracker/blocs/timestampBloc/timestampsEvent.dart';
import 'package:time_tracker/blocs/timestampBloc/timestampsState.dart';

import 'package:time_tracker/widgets/stopwatchDialog/stopwatchDialog.dart';
import 'package:time_tracker/timestampsRepository/timestampsRepository.dart';
import 'package:time_tracker/widgets/stopwatches/stopwatches.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.grey,
          primaryColor: Colors.grey,
          accentColor: Colors.white,
        ),
        home: BlocProvider<TimestampsBloc>(
          create: (context) {
            return TimestampsBloc(TimestampsRepository())
              ..add(LoadTimestamps());
          },
          child: BlocBuilder<TimestampsBloc, TimestampsState>(
            builder: (context, state) {
              return Scaffold(
                body: SafeArea(
                  child: Center(child: Stopwatches()),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    stopwatchDialogHandler(context);
                  },
                  tooltip: 'Add new timer',
                  child: Icon(Icons.add),
                ),
              );
            },
          ),
        ));
  }
}
