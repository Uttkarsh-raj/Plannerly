// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
sealed class HomeState {} //build state: used to build/re-build the ui

abstract class HomeActionState
    extends HomeState {} //action state:used to take some action in the ui

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeRefreshState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<TaskModel> regularTasks;
  final List<TaskModel> urgentTasks;
  final int totalUrgentTasks,
      totalRegularTasks,
      totalUrgentTasksCompleted,
      totalRegularTasksCompleted;
  final String name;
  HomeLoadedSuccessState(
      this.regularTasks,
      this.urgentTasks,
      this.totalUrgentTasks,
      this.totalRegularTasks,
      this.totalUrgentTasksCompleted,
      this.totalRegularTasksCompleted,
      this.name);
}

class HomeLoadedErrorState extends HomeState {}

class HomeErrorState extends HomeState {}

class HomeNavigateToUrgentTasksPage extends HomeActionState {}

class HomeNavigateToRegularTasksPage extends HomeActionState {}

class HomeDrawerButtonClickedState extends HomeActionState {}

//showing a snackbar is an action and thus we need an action state
class HomeTaskDeletedState extends HomeActionState {}

class HomeTaskCompletedState extends HomeActionState {}

class HomeUnableTofetchTasks extends HomeActionState {
  final String message;
  HomeUnableTofetchTasks({
    required this.message,
  });
}

class HomeNewTaskAddedState extends HomeActionState {}

class HomePopState extends HomeActionState {}

class HomeTaskAddedSuccessState extends HomeActionState {}

class HomeLogoutButtonClicked extends HomeActionState {}

class SearchLoadingState extends HomeState {}

class SearchSuccessState extends HomeState {
  final List<TaskModel> regTasks, urgTasks;

  SearchSuccessState({required this.regTasks, required this.urgTasks});
}

class SearchErrorState extends HomeState {
  final String message;

  SearchErrorState({required this.message});
}

class HomeSearchButtonClickedState extends HomeActionState {}
