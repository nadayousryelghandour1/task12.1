import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_trosc/todo_app/home/cubit/home_state.dart';

import '../../data/hive_data_storage.dart';
import '../../model/task.dart';

class HomeCubit extends Cubit<HomeState> {
  final HiveDataStorage hiveDataStorage;
  int ? number;

  HomeCubit(this.hiveDataStorage) : super(HomeInitial());

  static HomeCubit of(BuildContext context) =>
      BlocProvider.of<HomeCubit>(context);

  void loadTasks() async {
    emit(HomeLoading());
    try {
      List<Task> tasks = await hiveDataStorage.getAllTasks();
      tasks.sort((a, b) => a.createdAtDate.compareTo(b.createdAtDate));
      emit(HomeLoaded(tasks));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void deleteAllTasks (){
    hiveDataStorage.deleteAllTasks();
    emit(ClearHomePage([]));
  }

 int numOFTasks (){
   number = hiveDataStorage.numOfAllTasks();
   return number!;
 }
}
