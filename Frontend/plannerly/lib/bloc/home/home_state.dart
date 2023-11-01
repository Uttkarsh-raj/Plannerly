// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
sealed class HomeState {} //build state: used to build/re-build the ui

abstract class HomeActionState
    extends HomeState {} //action state:used to take some action in the ui

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<TaskModel> regularTasks;
  final List<TaskModel> urgentTasks;
  final int totalUrgentTasks,
      totalRegularTasks,
      totalUrgentTasksCompleted,
      totalRegularTasksCompleted;
  HomeLoadedSuccessState(
      this.regularTasks,
      this.urgentTasks,
      this.totalUrgentTasks,
      this.totalRegularTasks,
      this.totalUrgentTasksCompleted,
      this.totalRegularTasksCompleted);
}

class HomeLoadedErrorState extends HomeState {}

class HomeErrorState extends HomeState {}

class HomeNavigateToUrgentTasksPage extends HomeActionState {}

class HomeNavigateToRegularTasksPage extends HomeActionState {}

//showing a snackbar is an action and thus we need an action state
class HomeTaskDeletedState extends HomeActionState {}

class HomeTaskCompletedState extends HomeActionState {}

class HomeUnableTofetchTasks extends HomeActionState {
  final String message;
  HomeUnableTofetchTasks({
    required this.message,
  });
}
