import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:plannerly/view/home/home_loading.dart';
import 'package:plannerly/view/login/login.dart';
import 'package:plannerly/view/regular_tasks/regular_tasks_page.dart';
import 'package:plannerly/view/search/search.dart';
import 'package:plannerly/view/urgent_tasks/urgent_tasks_page.dart';
import 'package:plannerly/view/widgets/custom_drawer.dart';
import 'package:plannerly/view/widgets/form_field.dart';
import 'package:plannerly/view/widgets/task.dart';
import 'package:plannerly/utils/colors/colors.dart';

import '../../bloc/home/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final HomeBloc homeBloc = HomeBloc();
  TextEditingController titleContr = TextEditingController();
  TextEditingController descContr = TextEditingController();
  TextEditingController timeContr = TextEditingController();
  TextEditingController dateContr = TextEditingController();
  TextEditingController urgContr = TextEditingController();
  bool? urgent = false;
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    titleContr.dispose();
    descContr.dispose();
    timeContr.dispose();
    dateContr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) =>
          current is HomeActionState, //listen to changes when home action state
      buildWhen: (previous, current) => current
          is! HomeActionState, //any other state other than the home action state
      listener: (context, state) {
        //registed all the states you want to listen to
        if (state is HomeNavigateToUrgentTasksPage) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const UrgentTasks()));
        } else if (state is HomeNavigateToRegularTasksPage) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const RegularTasks()));
        } else if (state is HomeTaskCompletedState) {
          var snackbar = const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Congratulations !! Task completed successfully.",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.white,
              ),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        } else if (state is HomeTaskDeletedState) {
          var snackBar = SnackBar(
            backgroundColor: Colors.red[500],
            content: const Text(
              "Task deleted successfully !!",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.white,
              ),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is HomeUnableTofetchTasks) {
          var snackBar = SnackBar(
            backgroundColor: Colors.red[500],
            content: Text(
              state.message,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.white,
              ),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is HomeNewTaskAddedState) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                scrollable: true,
                title: const Center(
                  child: Text(
                    'Add new Task',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                content: SizedBox(
                  height: size.height * 0.65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TaskFormField(
                        title: "Title :",
                        hint: "Title",
                        controller: titleContr,
                      ),
                      const SizedBox(height: 14),
                      TaskFormField(
                        title: "Description :",
                        hint: "Description",
                        controller: descContr,
                        height: size.height * 0.16,
                        maxLines: 4,
                      ),
                      const SizedBox(height: 14),
                      TaskFormField(
                        title: "Date :",
                        hint: "DD/MM/YYYY",
                        controller: dateContr,
                      ),
                      const SizedBox(height: 14),
                      TaskFormField(
                        title: "Time :",
                        hint: "HH:MM:SS",
                        controller: timeContr,
                      ),
                      const SizedBox(height: 14),
                      TaskFormField(
                        title: "Urgent :",
                        hint: "True/False",
                        controller: urgContr,
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      homeBloc.add(HomeAddNewTaskCloseButtonClickedEvent());
                    },
                    child: const Text(
                      "Close",
                      style: TextStyle(
                        color: AppColors.buttonBlue,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      DateTime now = DateTime.now();
                      DateTime currentDate = DateTime(now.year, now.month,
                          now.day, now.hour, now.minute, now.second);
                      if (titleContr.text.isNotEmpty &&
                          descContr.text.isNotEmpty &&
                          dateContr.text.isNotEmpty &&
                          timeContr.text.isNotEmpty &&
                          urgContr.text.isNotEmpty) {
                        DateFormat dateFormat = DateFormat('dd/MM/yyyy');
                        DateFormat timeFormat = DateFormat('HH:mm:ss');
                        DateTime inputDate = dateFormat.parse(dateContr.text);
                        DateTime inputTime = timeFormat.parse(timeContr.text);
                        DateTime dateTime = DateTime(
                            inputDate.year,
                            inputDate.month,
                            inputDate.day,
                            inputTime.hour,
                            inputTime.minute,
                            inputTime.second);
                        if (dateTime.isAfter(currentDate)) {
                          homeBloc.add(
                            HomeAddNewTaskAddButtonClickedEvent(
                              title: titleContr.text.trim().toString(),
                              desc: descContr.text.trim().toString(),
                              date: dateContr.text.trim().toString(),
                              time: timeContr.text.trim().toString(),
                              urgent:
                                  urgContr.text.trim().toLowerCase().toString(),
                            ),
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: "Date and time must be in the future.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: AppColors.grey,
                            textColor: AppColors.backgroundDark,
                            fontSize: 16.0,
                          );
                        }
                      } else {
                        Fluttertoast.showToast(
                          msg: "Please provide information for all fields.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: AppColors.grey,
                          textColor: AppColors.backgroundDark,
                          fontSize: 16.0,
                        );
                      }
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(
                        color: AppColors.buttonBlue,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else if (state is HomePopState) {
          Navigator.of(context).pop();
        } else if (state is HomeTaskAddedSuccessState) {
          Navigator.of(context).pop();
          homeBloc.add(HomeInitialEvent());
        } else if (state is HomeDrawerButtonClickedState) {
          _scaffoldKey.currentState?.openDrawer();
        } else if (state is HomeLogoutButtonClicked) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        } else if (state is HomeSearchButtonClickedState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SearchPage(),
            ),
          );
        } else if (state is HomeLoginButtonClickedState) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const HomeLoading();
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              key: _scaffoldKey,
              drawer: CustomDrawer(
                homeBloc: homeBloc,
              ),
              backgroundColor: AppColors.backgroundDark,
              body: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Stack(
                  children: [
                    RefreshIndicator(
                      onRefresh: () async {
                        homeBloc.add(HomeInitialEvent());
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: size.height * 0.03),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    homeBloc
                                        .add(HomeDrawerButtonClickedEvent());
                                  },
                                  child: const Icon(
                                    Icons.menu_outlined,
                                    size: 28,
                                    color: AppColors.white,
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 19,
                                  backgroundColor: AppColors.backgroundDark,
                                  child: Image.asset(
                                    'assets/images/logo_transparent.png',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.03),
                            Text(
                              "Hi, ${state.name}",
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            const Text(
                              "Be productivity today",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: size.height * 0.038),
                            GestureDetector(
                              onTap: () {
                                homeBloc.add(HomeSearchButtonClickedEvent());
                              },
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.backgroundLight,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                              'Search task',
                                              style: TextStyle(
                                                color: AppColors.grey,
                                                fontSize: 18,
                                              ),
                                              // decoration: InputDecoration(
                                              //   border: InputBorder.none,
                                              //   hintText: 'Search task',
                                              //   hintStyle: TextStyle(
                                              //     color: AppColors.grey,
                                              //     fontSize: 18,
                                              //   ),
                                              //   contentPadding:
                                              //       EdgeInsets.all(10),
                                              // ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.search_outlined,
                                            size: 28,
                                            color: AppColors.white
                                                .withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.025),
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundLight,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Task Progress",
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "${state.totalRegularTasksCompleted + state.totalUrgentTasksCompleted}/${state.totalRegularTasks + state.totalUrgentTasks} task completed.",
                                              style: TextStyle(
                                                color: AppColors.white
                                                    .withOpacity(0.4),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Stack(
                                        children: [
                                          SizedBox(
                                            height: size.height * 0.07,
                                            width: size.height * 0.07,
                                            child: CircularProgressIndicator(
                                              value: ((state.totalRegularTasksCompleted +
                                                          state
                                                              .totalUrgentTasksCompleted) ==
                                                      0)
                                                  ? 0
                                                  : (state.totalRegularTasksCompleted +
                                                          state
                                                              .totalUrgentTasksCompleted) /
                                                      (state.totalRegularTasks +
                                                          state
                                                              .totalUrgentTasks),
                                              strokeWidth: 7,
                                              valueColor:
                                                  const AlwaysStoppedAnimation(
                                                      AppColors.buttonBlue),
                                              backgroundColor: AppColors.white
                                                  .withOpacity(0.2),
                                              color: AppColors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.07,
                                            width: size.height * 0.07,
                                            child: Center(
                                              child: Text(
                                                ((state.totalRegularTasksCompleted +
                                                            state
                                                                .totalUrgentTasksCompleted) ==
                                                        0)
                                                    ? "0%"
                                                    : "${((state.totalRegularTasksCompleted + state.totalUrgentTasksCompleted) / (state.totalRegularTasks + state.totalUrgentTasks) * 100).toStringAsFixed(1)}%",
                                                style: TextStyle(
                                                  color: AppColors.white
                                                      .withOpacity(0.8),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.04),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: size.height * 0.25,
                                  width: size.width * 0.45,
                                  decoration: BoxDecoration(
                                    color: AppColors.backgroundLight,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0)
                                        .copyWith(top: 12, bottom: 12),
                                    child: Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Urgent Tasks Progress",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            Center(
                                              child: Stack(
                                                children: [
                                                  SizedBox(
                                                    height: size.height * 0.1,
                                                    width: size.height * 0.1,
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: (state
                                                                  .totalUrgentTasksCompleted ==
                                                              0)
                                                          ? 0
                                                          : (state.totalUrgentTasksCompleted /
                                                              state
                                                                  .totalUrgentTasks),
                                                      strokeWidth: 7,
                                                      valueColor:
                                                          AlwaysStoppedAnimation(
                                                              Colors.red[400]),
                                                      backgroundColor: AppColors
                                                          .white
                                                          .withOpacity(0.2),
                                                      color: AppColors.white,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.1,
                                                    width: size.height * 0.1,
                                                    child: Center(
                                                      child: Text(
                                                        (state.totalUrgentTasksCompleted ==
                                                                0)
                                                            ? "0%"
                                                            : "${((state.totalUrgentTasksCompleted / state.totalUrgentTasks) * 100).toStringAsFixed(1)}%",
                                                        style: TextStyle(
                                                          color: AppColors.white
                                                              .withOpacity(0.8),
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Center(
                                              child: Text(
                                                "${state.totalUrgentTasksCompleted}/${state.totalUrgentTasks}",
                                                style: TextStyle(
                                                  color: AppColors.white
                                                      .withOpacity(0.4),
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: size.height * 0.25,
                                  width: size.width * 0.45,
                                  decoration: BoxDecoration(
                                    color: AppColors.backgroundLight,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0)
                                        .copyWith(top: 12, bottom: 12),
                                    child: Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Regular Tasks Progress",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            Center(
                                              child: Stack(
                                                children: [
                                                  SizedBox(
                                                    height: size.height * 0.1,
                                                    width: size.height * 0.1,
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: (state
                                                                  .totalRegularTasksCompleted ==
                                                              0)
                                                          ? 0
                                                          : (state.totalRegularTasksCompleted /
                                                              state
                                                                  .totalRegularTasks),
                                                      strokeWidth: 7,
                                                      valueColor:
                                                          AlwaysStoppedAnimation(
                                                              Colors
                                                                  .green[400]),
                                                      backgroundColor: AppColors
                                                          .white
                                                          .withOpacity(0.2),
                                                      color: AppColors.white,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.1,
                                                    width: size.height * 0.1,
                                                    child: Center(
                                                      child: Text(
                                                        (state.totalRegularTasksCompleted ==
                                                                0)
                                                            ? "0%"
                                                            : "${((state.totalRegularTasksCompleted / state.totalRegularTasks) * 100).toStringAsFixed(1)}%",
                                                        style: TextStyle(
                                                          color: AppColors.white
                                                              .withOpacity(0.8),
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Center(
                                              child: Text(
                                                "${state.totalRegularTasksCompleted}/${state.totalRegularTasks}",
                                                style: TextStyle(
                                                  color: AppColors.white
                                                      .withOpacity(0.4),
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.045),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Urgent Tasks",
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    homeBloc.add(
                                        HomeUrgentTasksViewAllClickedEvent());
                                  },
                                  child: const Text(
                                    'View all',
                                    style: TextStyle(
                                      color: AppColors.buttonBlue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Task(
                                bloc: homeBloc,
                                task: successState.urgentTasks[index],
                              ),
                              itemCount: (successState.urgentTasks.length < 2)
                                  ? successState.urgentTasks.length
                                  : 2,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(height: 15);
                              },
                            ),
                            SizedBox(height: size.height * 0.04),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Regular Tasks",
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    homeBloc.add(
                                        HomeRegularTasksViewAllClickedEvent());
                                  },
                                  child: const Text(
                                    'View all',
                                    style: TextStyle(
                                      color: AppColors.buttonBlue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Task(
                                bloc: homeBloc,
                                task: successState.regularTasks[index],
                              ),
                              itemCount: (successState.regularTasks.length < 2)
                                  ? successState.regularTasks.length
                                  : 2,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(height: 15);
                              },
                            ),
                            SizedBox(height: size.height * 0.1),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      width: size.width,
                      bottom: 8,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            homeBloc.add(HomeAddNewTaskButtonClickedEvent());
                          },
                          child: Container(
                            width: size.width * 0.7,
                            height: size.height * 0.07,
                            decoration: BoxDecoration(
                              color: AppColors.buttonBlue,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Center(
                              child: Text(
                                "Add new task +",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          case HomeLoadedErrorState:
            var s = state as HomeLoadedErrorState;
            return Scaffold(
              backgroundColor: AppColors.backgroundDark,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.red[400],
                          ),
                          const SizedBox(width: 10),
                          Center(
                            child: Expanded(
                              child: Text(
                                s.error,
                                maxLines: 3,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.white.withOpacity(0.3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Try to refresh.",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              homeBloc.add(HomeInitialEvent());
                            },
                            child: const Center(
                              child: Text(
                                "Refresh",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: AppColors.buttonBlue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Please try to login again.",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              homeBloc.add(HomeLoginButtonClickedEvent());
                            },
                            child: const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: AppColors.buttonBlue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
