import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:plannerly/models/local_notifications.dart';
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
    on<HomeDrawerButtonClickedEvent>(homeDrawerButtonClickedEvent);
    on<HomeLogoutButtonClickedEvent>(homeLogoutButtonClickedEvent);
    on<SearchForTasksEvent>(searchForTasksEvent);
    on<HomeSearchButtonClickedEvent>(homeSearchButtonClickedEvent);
    on<HomeLoginButtonClickedEvent>(homeLoginButtonClickedEvent);
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
    String name = sp.getString('userName')!;
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
        emit(HomeLoadedErrorState(error: response["error"]));
      }

      res = await http.get(
        Uri.parse("$baseUrl/tasks/regular"),
        headers: {"token": token},
      );
      // print("res: ${res.body}");
      response = jsonDecode(res.body);
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
              name),
        );
      } else {
        emit(HomeLoadedErrorState(error: response["error"]));
      }
    } catch (e) {
      emit(HomeLoadedErrorState(error: e.toString()));
      log(e.toString());
    }
    // emit(HomeLoadedSuccessState(regualarTasks, urgentTasks, totalUrgentTasks,
    //     totalRegularTasks, urgentTasksCompleted, regularTasksCompleted, name));
  }

  Map<String, int> convertToUtcDateTime(String inputDate, String inputTime) {
    // Parse input date and time
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateFormat timeFormat = DateFormat('HH:mm:ss');
    DateTime date = dateFormat.parse(inputDate);
    DateTime time = timeFormat.parse(inputTime);

    // Combine date and time to create a DateTime object
    DateTime dateTime = DateTime(
        date.year, date.month, date.day, time.hour, time.minute, time.second);

    // Convert to UTC
    tz.TZDateTime utcDateTime = tz.TZDateTime.from(dateTime, tz.UTC);

    // Return separate date and time components as integers
    return {
      'utcYear': utcDateTime.year,
      'utcMonth': utcDateTime.month,
      'utcDay': utcDateTime.day,
      'utcHour': utcDateTime.hour,
      'utcMinute': utcDateTime.minute,
      'utcSecond': utcDateTime.second,
    };
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
    var userId = sp.getString('userId');
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
      print(event.date + " " + event.time);
      Map<String, int> utcDateTimeComponents =
          convertToUtcDateTime(event.date, event.time);
      print("UTC Year: ${utcDateTimeComponents['utcYear']}");
      print("UTC Month: ${utcDateTimeComponents['utcMonth']}");
      print("UTC Day: ${utcDateTimeComponents['utcDay']}");
      print("UTC Hour: ${utcDateTimeComponents['utcHour']}");
      print("UTC Minute: ${utcDateTimeComponents['utcMinute']}");
      print("UTC Second: ${utcDateTimeComponents['utcSecond']}");
      await LocalNotifications.scheduleNotifications(
        body: event.desc,
        title: event.title,
        payload: event.desc,
        year: utcDateTimeComponents['utcYear']!,
        month: utcDateTimeComponents['utcMonth']!,
        day: utcDateTimeComponents['utcDay']!,
        hour: utcDateTimeComponents['utcHour']!,
        minutes: utcDateTimeComponents['utcMinute']!,
        seconds: utcDateTimeComponents['utcSecond']!,
      );
      emit(HomeTaskAddedSuccessState());
    } else {
      emit(HomeUnableTofetchTasks(message: response["error"]));
    }
  }

  FutureOr<void> homeDrawerButtonClickedEvent(
      HomeDrawerButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeDrawerButtonClickedState());
  }

  FutureOr<void> homeLogoutButtonClickedEvent(
      HomeLogoutButtonClickedEvent event, Emitter<HomeState> emit) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("token", "");
    sp.setString('userId', "");
    sp.setString('userName', "");
    emit(HomeLogoutButtonClicked());
  }

  FutureOr<void> searchForTasksEvent(
      SearchForTasksEvent event, Emitter<HomeState> emit) async {
    List<TaskModel> regTasks = [];
    List<TaskModel> urgTasks = [];
    emit(SearchLoadingState());
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token')!;
    var uri = Uri.parse(
      "$baseUrl/search",
    );
    try {
      var res = await http.post(uri,
          body: jsonEncode({"search": event.searchString}),
          headers: {"token": token});
      var response = jsonDecode(res.body);
      print(res.body);
      print(response);
      if (response['success']) {
        List<dynamic> regs = response['data']['regularTasks'];
        List<dynamic> urgs = response['data']['urgentTasks'];
        regTasks = regs
            .map(
              (task) => TaskModel(
                taskId: task["ID"],
                userId: task["user_id"],
                title: task["title"],
                description: task["desc"],
                time: task["time"],
                date: task["date"],
                completed: task["completed"],
                urgent: task["urgent"],
              ),
            )
            .toList();
        urgTasks = urgs
            .map(
              (task) => TaskModel(
                taskId: task["ID"],
                userId: task["user_id"],
                title: task["title"],
                description: task["desc"],
                time: task["time"],
                date: task["date"],
                completed: task["completed"],
                urgent: task["urgent"],
              ),
            )
            .toList();
        emit(
          SearchSuccessState(regTasks: regTasks, urgTasks: urgTasks),
        );
      } else {
        emit(SearchErrorState(message: response['error']));
      }
    } catch (e) {
      emit(SearchErrorState(message: e.toString()));
    }
  }

  FutureOr<void> homeSearchButtonClickedEvent(
      HomeSearchButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeSearchButtonClickedState());
  }

  FutureOr<void> homeLoginButtonClickedEvent(
      HomeLoginButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeLoginButtonClickedState());
  }
}
