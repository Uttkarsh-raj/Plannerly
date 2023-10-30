import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeUrgentTasksViewAllClickedEvent>(homeUrgentTasksViewAllClickedEvent);
    on<HomeRegularTasksViewAllClickedEvent>(
        homeRegularTasksViewAllClickedEvent);
  }

  FutureOr<void> homeUrgentTasksViewAllClickedEvent(
      HomeUrgentTasksViewAllClickedEvent event, Emitter<HomeState> emit) {
    print('View Urgent Page');
  }

  FutureOr<void> homeRegularTasksViewAllClickedEvent(
      HomeRegularTasksViewAllClickedEvent event, Emitter<HomeState> emit) {
    print('View Regular Page');
  }
}
