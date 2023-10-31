import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:plannerly/models/task_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeUrgentTasksViewAllClickedEvent>(homeUrgentTasksViewAllClickedEvent);
    on<HomeRegularTasksViewAllClickedEvent>(
        homeRegularTasksViewAllClickedEvent);
    on<HomeTasksCompletedButtonClicked>(homeTasksCompletedButtonClicked);
    on<HomeTasksDeleteButtonClicked>(homeTasksDeleteButtonClicked);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 3));
    List<TaskModel> regualarTasks = [
      TaskModel(
        taskId: "000000000000000000000000",
        userId: "653a2f71e2330ac369e93c9b",
        title: "Task 3",
        description: "This is the First task of regular type.",
        time: "10:00:00",
        date: "24/10/2023",
        completed: false,
        urgent: false,
      ),
      TaskModel(
        taskId: "000000000000000000000001",
        userId: "653a2f71e2330ac369e93c9b",
        title: "Task 4",
        description: "This is the Second task of regular type.",
        time: "10:00:00",
        date: "25/10/2023",
        completed: false,
        urgent: false,
      )
    ];
    List<TaskModel> urgentTasks = [
      TaskModel(
        taskId: "000000000000000000000000",
        userId: "653a2f71e2330ac369e93c9b",
        title: "Task 1",
        description:
            "This is the First taska.sfshlfhslfhlshfljsf.sdkjfjhahfksahihas",
        time: "10:00:00",
        date: "24/10/2023",
        completed: false,
        urgent: true,
      ),
      TaskModel(
        taskId: "000000000000000000000001",
        userId: "653a2f71e2330ac369e93c9b",
        title: "Task 2",
        description: "This is the Second task",
        time: "10:00:00",
        date: "25/10/2023",
        completed: false,
        urgent: true,
      )
    ];

    emit(
      HomeLoadedSuccessState(
        regualarTasks,
        urgentTasks,
      ),
    );
  }

  FutureOr<void> homeUrgentTasksViewAllClickedEvent(
      HomeUrgentTasksViewAllClickedEvent event, Emitter<HomeState> emit) {
    print('View Urgent Page');
    emit(HomeNavigateToUrgentTasksPage());
  }

  FutureOr<void> homeRegularTasksViewAllClickedEvent(
      HomeRegularTasksViewAllClickedEvent event, Emitter<HomeState> emit) {
    print('View Regular Page');
    emit(HomeNavigateToRegularTasksPage());
  }

  FutureOr<void> homeTasksCompletedButtonClicked(
      HomeTasksCompletedButtonClicked event, Emitter<HomeState> emit) {
    print("Task completed button clicked");
  }

  FutureOr<void> homeTasksDeleteButtonClicked(
      HomeTasksDeleteButtonClicked event, Emitter<HomeState> emit) {
    print("Task deleted button clicked");
  }
}
