import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_trosc/todo_app/model/task.dart';

class HiveDataStorage {
  static const boxName = 'tasksBox';

  final Box<Task> box = Hive.box<Task>(boxName);

  Future<void> addTask(Task task) async {
    debugPrint('Task added: ${task.id}');
    await box.put(task.id, task);
  }

  Future<void> updateTask(Task task) async {
    debugPrint('Task updated: ${task.id}');
    await task.save();
  }

  Future<void> deleteTask(Task task) async {
    debugPrint('Task deleted: ${task.id}');
    await task.delete();
  }

  Future<List<Task>> getAllTasks() async {
    debugPrint('Tasks: ${box.values.toList()}');
    return box.values.toList();
  }

  Future<Task?> getTask({required String id}) async {
    debugPrint('Task: ${box.get(id)}');
    return box.get(id)!;
  }

  Future<void> deleteAllTasks() async {
    debugPrint('Tasks deleted');
    await box.clear();
  }

  ValueListenable<Box<Task>> listenToTask() {
    debugPrint("Tasks: ${box.listenable()}");
    return box.listenable();
  }

  int numOfAllTasks(){
    debugPrint('num of tasks');
    return box.length;
  }
}
