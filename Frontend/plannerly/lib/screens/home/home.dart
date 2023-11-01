import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plannerly/screens/regular_tasks/regular_tasks_page.dart';
import 'package:plannerly/screens/urgent_tasks/urgent_tasks_page.dart';
import 'package:plannerly/screens/widgets/task.dart';
import 'package:plannerly/utils/colors/colors.dart';

import '../../bloc/home/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
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
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              backgroundColor: AppColors.backgroundDark,
              body: Center(child: CircularProgressIndicator()),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              backgroundColor: AppColors.backgroundDark,
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.03),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.menu_outlined,
                            size: 28,
                            color: AppColors.white,
                          ),
                          Icon(
                            Icons.notifications_outlined,
                            size: 28,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.03),
                      const Text(
                        "Hi, Jason",
                        style: TextStyle(
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
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.backgroundLight,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search task',
                                      hintStyle: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: 18,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.search_outlined,
                                    size: 28,
                                    color: AppColors.white.withOpacity(0.6),
                                  ),
                                ),
                              ],
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          color:
                                              AppColors.white.withOpacity(0.4),
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
                                                    state.totalUrgentTasks),
                                        strokeWidth: 7,
                                        valueColor:
                                            const AlwaysStoppedAnimation(
                                                AppColors.buttonBlue),
                                        backgroundColor:
                                            AppColors.white.withOpacity(0.2),
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
                                              child: CircularProgressIndicator(
                                                value: (state
                                                            .totalUrgentTasksCompleted ==
                                                        0)
                                                    ? 0
                                                    : (state.totalUrgentTasksCompleted /
                                                        state.totalUrgentTasks),
                                                strokeWidth: 7,
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Colors.red[400]),
                                                backgroundColor: AppColors.white
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
                                                    fontWeight: FontWeight.w600,
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
                                              child: CircularProgressIndicator(
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
                                                        Colors.green[400]),
                                                backgroundColor: AppColors.white
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
                                                    fontWeight: FontWeight.w600,
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
                              homeBloc
                                  .add(HomeUrgentTasksViewAllClickedEvent());
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
                        separatorBuilder: (BuildContext context, int index) {
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
                              homeBloc
                                  .add(HomeRegularTasksViewAllClickedEvent());
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
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 15);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          case HomeLoadedErrorState:
            return Scaffold(
              backgroundColor: AppColors.backgroundDark,
              body: Center(
                child: Text(
                  'Some error ocurred!',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.white.withOpacity(0.3),
                  ),
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