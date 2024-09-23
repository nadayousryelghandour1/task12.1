import 'package:flutter/material.dart';
import 'package:todo_trosc/todo_app/model/task.dart';
import 'package:todo_trosc/todo_app/tasks/cubit/task_cubit.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/strings.dart';

Widget bottomButtons(BuildContext context, TaskCubit taskCubit ,bool isEditing , Task? task) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(
      mainAxisAlignment:
          isEditing ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
      children: [
        isEditing
            ? Container(
                width: 150,
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(color: MyColors.primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minWidth: 150,
                  height: 55,
                  onPressed: () async {
                    taskCubit.deleteTask(context,task!);
                  },
                  color: Colors.white,
                  child: const Row(
                    children: [
                      Icon(
                        Icons.close,
                        color: MyColors.primaryColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        MyString.deleteTask,
                        style: TextStyle(
                          color: MyColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          minWidth: 150,
          height: 55,
          onPressed: () async {
            taskCubit.addTask(context);
            
          },
          color: MyColors.primaryColor,
          child: Text(
            isEditing ? MyString.updateTaskString : MyString.addNewTask,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    ),
  );
}
