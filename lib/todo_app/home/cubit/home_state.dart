import '../../model/task.dart';

sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Task> tasks;

  HomeLoaded(this.tasks);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}

class ClearHomePage extends HomeLoaded {

  ClearHomePage(super.tasks);

}

class UpdateHomePage extends HomeLoaded {

  UpdateHomePage(super.tasks);

}

