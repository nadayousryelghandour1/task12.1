import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:todo_trosc/todo_app/data/hive_data_storage.dart';
import 'package:todo_trosc/todo_app/tasks/cubit/task_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constanst.dart';

import '../../model/task.dart';

class TaskCubit extends Cubit<TaskState> {
  final HiveDataStorage hiveDataStorage;

  TaskCubit(this.hiveDataStorage) : super(TaskInitial()) {
    titleController = TextEditingController();
    subtitleController = TextEditingController();
  }

  static TaskCubit of(BuildContext context) =>
      BlocProvider.of<TaskCubit>(context);

  TextEditingController? titleController;
  TextEditingController? subtitleController;
  DateTime? time;
  DateTime? date;
  int taskcounter = 0 ;

  @override
  Future<void> close() {
    titleController!.dispose();
    subtitleController!.dispose();
    return super.close();
  }

  void loadTasks() async {
    emit(TaskLoading());
    try {
      List<Task> tasks = await hiveDataStorage.getAllTasks();
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  void setTime(DateTime time) {
    final now = DateTime.now();
    this.time = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    emit(TaskTimeUpdated(this.time!));
  }

  String showTime(DateTime? time) {
    if (time == null) {
      return DateFormat('hh:mm a').format(DateTime.now()).toString();
    }
    return DateFormat('hh:mm a').format(time).toString();
  }

  void setDate(DateTime newDate) {
    date = newDate;
    emit(TaskDateUpdated(date!));
  }

  String showDate(DateTime? date) {
    if (date == null) {
      return DateFormat.yMMMEd().format(DateTime.now()).toString();
    } else {
      return DateFormat.yMMMEd().format(date).toString();
    }
  }

  void addTask(BuildContext context) {
    // try {
    if (titleController!.text.isNotEmpty &&
        subtitleController!.text.isNotEmpty) {
      final task = Task.create(
        title: titleController!.text,
        subtitle: subtitleController!.text,
        createdAtDate: date,
        createdAtTime: time,
      );
      hiveDataStorage.addTask(task);
      loadTasks();
      Navigator.pop(context);
    } else {
      emptyFieldsWarning(context);
      emit(TaskError('Title and subtitle must not be empty'));
    }
    // } catch (e) {
    //   emptyFieldsWarning(context);
    //   emit(TaskError(e.toString()));
    // }
  }

  void deleteTask(BuildContext context,Task task){
    hiveDataStorage.deleteTask(task);
    loadTasks();
    Navigator.pop(context);
  }

  

}
