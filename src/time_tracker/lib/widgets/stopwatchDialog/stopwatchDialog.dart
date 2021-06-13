import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:time_tracker/blocs/timestampBloc/timestampsBloc.dart';
import 'package:time_tracker/blocs/timestampBloc/timestampsEvent.dart';
import 'package:time_tracker/models/timestamp.dart';

void stopwatchDialogHandler(BuildContext context) async {
  var result = await showDialog(
      context: context, builder: (context) => StopwatchDialog()) as Timestamp?;

  if (result != null) {
    BlocProvider.of<TimestampsBloc>(context).add(
      AddTimestamp(result),
    );
  }
}

class StopwatchDialog extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var _formKey = useMemoized(() => GlobalKey<FormState>());
    var _nameInputController = useMemoized(() => TextEditingController());

    return AlertDialog(
      title: Text('New time tracker'),
      titlePadding: EdgeInsets.all(15),
      contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 0),
      content: Form(
          key: _formKey,
          child: ListView(shrinkWrap: true, children: [
            TextFormField(
              decoration: InputDecoration(hintText: 'Name'),
              controller: _nameInputController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
          ])),
      actions: [
        FractionallySizedBox(
          widthFactor: 0.5,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pop(context, null);
            },
            child: Text(
              'Cancel',
            ),
          ),
        ),
        FractionallySizedBox(
          widthFactor: 0.45,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pop(context, Timestamp(_nameInputController.text));
              }
            },
            child: Text(
              'Create',
            ),
          ),
        ),
      ],
    );
  }
}
