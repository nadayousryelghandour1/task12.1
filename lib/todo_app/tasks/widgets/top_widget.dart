import 'package:flutter/material.dart';

import '../../../core/utils/strings.dart';

Widget topText(TextTheme textTheme , bool isEditing) {
  return SizedBox(
    width: double.infinity,
    height: 100,

    child: isEditing ? Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: 70,
          child: Divider(
            thickness: 2,
          ),
        ),
        RichText(
          text: TextSpan(
              text: "Update ",
              style: textTheme.titleLarge,
              children: const [
                TextSpan(
                  text: 'Task',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                )
              ]),
        ),
        const SizedBox(
          width: 70,
          child: Divider(
            thickness: 2,
          ),
        ),
      ],
    )
   :
  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: 70,
          child: Divider(
            thickness: 2,
          ),
        ),
        RichText(
          text: TextSpan(
              text: MyString.addNewTask,
              style: textTheme.titleLarge,
              children: const [
                TextSpan(
                  text: MyString.taskStrnig,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                )
              ]),
        ),
        const SizedBox(
          width: 70,
          child: Divider(
            thickness: 2,
          ),
        ),
      ],
    )
  );
}
