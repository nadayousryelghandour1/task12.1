import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_trosc/todo_app/model/task.dart';
import 'package:todo_trosc/todo_app/tasks/task_view.dart';

import '../../../core/utils/colors.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
    required this.task,
  });

  final Task task;

  

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) =>  TaskView(
              task: task, isEditing: true,
            )));
      },
      child: AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.1),
                offset: const Offset(0, 4),
                blurRadius: 10)
          ]),
      child: ListTile(
        leading: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            color: task.isCompleted ? MyColors.primaryColor : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey, width: .8),
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
        title: Text(
          task.title,
          style: TextStyle(
              color: task.isCompleted ? MyColors.primaryColor : Colors.black,
              fontWeight: FontWeight.w500,
              decoration: task.isCompleted ? TextDecoration.lineThrough : null),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.subtitle,
              style: const TextStyle(
                color: Color.fromARGB(255, 164, 164, 164),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                children: [
                  Text(
                    DateFormat('hh:mm a').format(task.createdAtTime),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMEd().format(task.createdAtDate),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
