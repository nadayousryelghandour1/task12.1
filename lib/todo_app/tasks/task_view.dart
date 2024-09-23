// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_trosc/todo_app/data/hive_data_storage.dart';
import 'package:todo_trosc/todo_app/tasks/cubit/task_cubit.dart';
import 'package:todo_trosc/todo_app/tasks/widgets/build_already_exist_task.dart';

import '../model/task.dart';
import 'cubit/task_state.dart';
import 'widgets/bottom_buttons.dart';
import 'widgets/build_text_field_and_date_time.dart';
import 'widgets/my_appbar.dart';
import 'widgets/top_widget.dart';

class TaskView extends StatelessWidget {
  final Task? task;
  final bool isEditing;
  const TaskView({super.key, required this.task, required this.isEditing });


  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    if (isEditing == true ){
      return BlocProvider(
      create: (context) => TaskCubit(HiveDataStorage()),
      child: BlocBuilder<TaskCubit, TaskState>
      (builder: (BuildContext context, TaskState state) {
         final taskCubit = TaskCubit.of(context);
         return Scaffold(
            backgroundColor: Colors.white,
            appBar: const MyAppBar(),
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      topText(textTheme , true),
                      BuildAlreadyExistTask(task: task,),
                      bottomButtons(context, taskCubit ,true,task),
                    ],
                  ),
                ),
              ),
            ),
          );
       },

      )
      );
    }
    
    else{
      return BlocProvider(
      create: (context) => TaskCubit(HiveDataStorage()),
      child: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          final taskCubit = TaskCubit.of(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: const MyAppBar(),
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      topText(textTheme , false),
                      const BuildTextFieldAndDateTimePicker(),
                      bottomButtons(context, taskCubit , false,task),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
    }
   
  }
}
