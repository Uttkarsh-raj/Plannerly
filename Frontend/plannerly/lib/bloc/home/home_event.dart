// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent
    extends HomeEvent {} // the one event that is called as soon as the app is opened i.e. the first thing to be called

class HomeUrgentTasksViewAllClickedEvent extends HomeEvent {}

class HomeRegularTasksViewAllClickedEvent extends HomeEvent {}

class HomeTasksDeleteButtonClicked extends HomeEvent {
  final TaskModel taskDeleted;
  HomeTasksDeleteButtonClicked({
    required this.taskDeleted,
  });
}

class HomeTasksCompletedButtonClicked extends HomeEvent {
  final TaskModel taskCompleted;
  HomeTasksCompletedButtonClicked({
    required this.taskCompleted,
  });
}
