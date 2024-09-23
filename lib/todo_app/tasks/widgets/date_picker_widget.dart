import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_trosc/todo_app/tasks/cubit/task_cubit.dart';

import '../../../../core/utils/colors.dart';

Widget datePickerWidget(TaskCubit taskCubit, BuildContext context) {
  return Container(
    height: 270,
    color: Colors.white,
    child: Column(
      children: [
        SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now().add(
              const Duration(minutes: 30),
            ),
            minimumDate: DateTime.now(),
            maximumDate: DateTime(2030, 3, 5),
            onDateTimeChanged: (DateTime newDate) {
              taskCubit.date = newDate;
            },
          ),
        ),
        CupertinoButton(
          child: const Text('Done',
              style: TextStyle(
                color: MyColors.primaryColor,
                fontSize: 20,
              )),
          onPressed: () {
            Navigator.of(context).pop(taskCubit.date);
          },
        ),
      ],
    ),
  );
}
