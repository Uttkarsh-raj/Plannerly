import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:plannerly/models/task_model.dart';
import 'package:http/http.dart' as http;
import 'package:plannerly/utils/server/server_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    on<HomeAddNewTaskButtonClickedEvent>(homeAddNewTaskButtonClickedEvent);
    on<HomeAddNewTaskCloseButtonClickedEvent>(
        homeAddNewTaskCloseButtonClickedEvent);
    on<HomeAddNewTaskAddButtonClickedEvent>(
        homeAddNewTaskAddButtonClickedEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    List<TaskModel> regualarTasks = [];
    List<TaskModel> urgentTasks = [];
    int totalUrgentTasks = 0,
        totalRegularTasks = 0,
        urgentTasksCompleted = 0,
        regularTasksCompleted = 0;
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token')!;
    try {
      var uri = Uri.parse("$baseUrl/tasks/urgent");
      var res = await http.get(
        uri,
        headers: {"token": token},
      );
      var response = jsonDecode(res.body);
      if (response["success"]) {
        List<dynamic> data = response["data"];
        totalUrgentTasks = response["total"];
        urgentTasksCompleted = response["completed"];
        urgentTasks = data.map((task) {
          return TaskModel(
            taskId: task["ID"],
            userId: task["user_id"],
            title: task["title"],
            description: task["desc"],
            time: task["time"],
            date: task["date"],
            completed: task["completed"],
            urgent: task["urgent"],
          );
        }).toList();
      } else {
        emit(HomeUnableTofetchTasks(message: response["error"]));
      }
    } catch (e) {
      emit(HomeUnableTofetchTasks(message: "Unable to get the data."));
      log(e.toString());
    }

    try {
      var res = await http.get(
        Uri.parse("$baseUrl/tasks/regular"),
        headers: {"token": token},
      );
      // print("res: ${res.body}");
      var response = jsonDecode(res.body);
      // print("response: $response");
      if (response["success"]) {
        List<dynamic> data = response["data"];
        totalRegularTasks = response["total"];
        regularTasksCompleted = response["completed"];
        regualarTasks = data.map((task) {
          return TaskModel(
            taskId: task["ID"],
            userId: task["user_id"],
            title: task["title"],
            description: task["desc"],
            time: task["time"],
            date: task["date"],
            completed: task["completed"],
            urgent: task["urgent"],
          );
        }).toList();
        emit(
          HomeLoadedSuccessState(
            regualarTasks,
            urgentTasks,
            totalUrgentTasks,
            totalRegularTasks,
            urgentTasksCompleted,
            regularTasksCompleted,
          ),
        );
      } else {
        emit(HomeUnableTofetchTasks(message: response["error"]));
      }
    } catch (e) {
      emit(HomeUnableTofetchTasks(message: "Unable to get the data."));
      log(e.toString());
    }
  }

  FutureOr<void> homeUrgentTasksViewAllClickedEvent(
      HomeUrgentTasksViewAllClickedEvent event, Emitter<HomeState> emit) {
    print('View Urgent Page');
    emit(HomeNavigateToUrgentTasksPage());
  }

  FutureOr<void> homeRegularTasksViewAllClickedEvent(
      HomeRegularTasksViewAllClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToRegularTasksPage());
  }

  FutureOr<void> homeTasksCompletedButtonClicked(
      HomeTasksCompletedButtonClicked event, Emitter<HomeState> emit) async {
    var uri = Uri.parse("$baseUrl/update/${event.taskCompleted.taskId}");
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token')!;
    try {
      var res = await http.patch(
        uri,
        headers: {"token": token},
        body: jsonEncode({"completed": true}),
      );
      var response = jsonDecode(res.body);
      if (response['success']) {
        emit(HomeTaskCompletedState());
      } else {
        emit(HomeUnableTofetchTasks(message: response["error"]));
      }
    } catch (e) {
      emit(HomeUnableTofetchTasks(message: e.toString()));
    }
  }

  FutureOr<void> homeTasksDeleteButtonClicked(
      HomeTasksDeleteButtonClicked event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token')!;
    var uri = Uri.parse("$baseUrl/delete/${event.taskDeleted.taskId}");
    try {
      var res = await http.delete(
        uri,
        headers: {"token": token},
      );
      var response = jsonDecode(res.body);
      if (response["success"]) {
        emit(HomeTaskDeletedState());
      } else {
        emit(HomeUnableTofetchTasks(message: response["error"]));
      }
    } catch (e) {
      emit(HomeUnableTofetchTasks(message: e.toString()));
    }
  }

  FutureOr<void> homeAddNewTaskButtonClickedEvent(
      HomeAddNewTaskButtonClickedEvent event, Emitter<HomeState> emit) {
    print("Add a new task");
    emit(HomeNewTaskAddedState());
    // emit(HomeInitial());
  }

  FutureOr<void> homeAddNewTaskCloseButtonClickedEvent(
      HomeAddNewTaskCloseButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomePopState());
  }

  FutureOr<void> homeAddNewTaskAddButtonClickedEvent(
      HomeAddNewTaskAddButtonClickedEvent event,
      Emitter<HomeState> emit) async {
    print("object");
    emit(HomeLoadingState());
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token')!;
    var url = Uri.parse("$baseUrl/addTask");
    bool val = (event.urgent.toLowerCase() == "true") ? true : false;
    var res = await http.post(
      url,
      headers: {"token": token},
      body: jsonEncode(
        {
          "user_id": userId,
          "title": event.title,
          "desc": event.desc,
          "time": event.time,
          "date": event.date,
          "completed": false,
          "urgent": val,
        },
      ),
    );
    var response = jsonDecode(res.body);
    print(response);
    if (response["success"] == true) {
      emit(HomeTaskAddedSuccessState());
    } else {
      emit(HomeUnableTofetchTasks(message: response["error"]));
    }
  }
}
