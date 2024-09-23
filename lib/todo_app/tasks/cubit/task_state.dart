import '../../model/task.dart';

sealed class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  TaskLoaded(this.tasks);
}

class TaskError extends TaskState {
  final String message;

  TaskError(this.message);
}

class TaskTimeUpdated extends TaskState {
  final DateTime time;

  TaskTimeUpdated(this.time);
} 

class TaskDateUpdated extends TaskState {
  DateTime date;

  TaskDateUpdated(this.date);
}

class TaskDelete extends TaskState{

}
