import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_trosc/core/utils/constanst.dart';
import 'package:todo_trosc/todo_app/home/cubit/home_cubit.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/strings.dart';
import '../cubit/home_state.dart';
import 'task_widget.dart';

Widget buildBody(TextTheme textTheme) {
  return BlocBuilder<HomeCubit, HomeState>(
    builder: (context, state) {
      if (state is HomeLoading) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(MyColors.primaryColor),
          ),
        );
      }
      if (state is HomeError) {
        return Center(
          child: Text(state.message),
        );
      }
      if (state is HomeLoaded) {
        int number = HomeCubit.of(context).numOFTasks();
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(55, 0, 0, 0),
              height: 100,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(MyColors.primaryColor),
                      backgroundColor: Colors.grey,
                      value: 0.5,
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        MyString.mainTitle,
                        style: textTheme.displayLarge,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        '0 of $number tasks',
                        style: textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Divider(
                thickness: 2,
                indent: 100,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 585,
              child: false
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeIn(
                          child: Lottie.asset(
                            lottieURL,
                            width: 200,
                            height: 200,
                            animate: true,
                          ),
                        ),
                        FadeInUp(
                          from: 30,
                          child: const Text(MyString.doneAllTask),
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.horizontal,
                          background: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete_outline,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(MyString.deletedTask,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ))
                            ],
                          ),
                          onDismissed: (direction) {},
                          child: TaskWidget(
                            task: state.tasks[index],
                          ),
                        );
                      }),
            )
          ],
        );
      } else {
        return Container();
      }
    },
  );
}
