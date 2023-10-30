part of 'home_bloc.dart';

@immutable
sealed class HomeState {} //build state: used to build/re-build the ui

abstract class HomeActionState
    extends HomeState {} //action state:used to take some action in the ui

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {}

class HomeErrorState extends HomeState {}

class HomeNavigateToUrgentTasksPage extends HomeActionState {}

class HomeNavigateToRegularTasksPage extends HomeActionState {}
