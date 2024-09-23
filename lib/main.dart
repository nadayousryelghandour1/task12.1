import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_trosc/todo_app/home/cubit/home_cubit.dart';
import 'package:todo_trosc/todo_app/home/home_view.dart';

import 'core/utils/theme.dart';
import 'todo_app/data/hive_data_storage.dart';
import 'todo_app/model/task.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  var box = await Hive.openBox<Task>(HiveDataStorage.boxName);

  /// Delete data from previous day
  for (var task in box.values) {
    if (task.createdAtTime.day != DateTime.now().day) {
      task.delete();
    } else {}
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: themeData,
      navigatorObservers: [routeObserver],
      home: BlocProvider(
        create: (context) => HomeCubit(HiveDataStorage())..loadTasks(),
        child: const HomeView(),
      ),
    );
  }
}
