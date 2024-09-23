import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_trosc/main.dart';
import 'package:todo_trosc/todo_app/home/cubit/home_cubit.dart';

import '../../core/utils/constanst.dart';
import 'cubit/home_state.dart';
import 'widgets/build_body.dart';
import 'widgets/fab.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    BlocProvider.of<HomeCubit>(context).loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () async {
                  if (state is HomeLoaded && state.tasks.isEmpty) {
                    warningNoTask(context);
                  } else {
                    await deleteAllTask(context);
                    HomeCubit.of(context).deleteAllTasks();
                  }
                },
                icon: const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(
                    CupertinoIcons.trash,
                    size: 40,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: const FAB(),
      body: buildBody(textTheme),
    );
  }
}
