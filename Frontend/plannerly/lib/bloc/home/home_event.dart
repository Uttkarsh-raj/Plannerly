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

class HomeAddNewTaskButtonClickedEvent extends HomeEvent {}

class HomeAddNewTaskCloseButtonClickedEvent extends HomeEvent {}

class HomeAddNewTaskAddButtonClickedEvent extends HomeEvent {
  final String title;
  final String desc;
  final String date;
  final String time;
  final String urgent;
  HomeAddNewTaskAddButtonClickedEvent({
    required this.title,
    required this.desc,
    required this.date,
    required this.time,
    required this.urgent,
  });
}

class HomeDrawerButtonClickedEvent extends HomeEvent {}
