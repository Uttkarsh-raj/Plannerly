part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeUrgentTasksViewAllClickedEvent extends HomeEvent {}

class HomeRegularTasksViewAllClickedEvent extends HomeEvent {}
