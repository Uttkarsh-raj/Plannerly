import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plannerly/bloc/home/home_bloc.dart';
import 'package:plannerly/view/home/home_loading.dart';
import 'package:plannerly/view/widgets/task.dart';
import 'package:plannerly/utils/colors/colors.dart';

class RegularTasks extends StatefulWidget {
  const RegularTasks({super.key});

  @override
  State<RegularTasks> createState() => _RegularTasksState();
}

class _RegularTasksState extends State<RegularTasks> {
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
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomePopState) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const HomeLoading();
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              backgroundColor: AppColors.backgroundDark,
              body: RefreshIndicator(
                onRefresh: () async {
                  homeBloc.add(HomeInitialEvent());
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                homeBloc.add(
                                    HomeAddNewTaskCloseButtonClickedEvent());
                              },
                              icon: const Icon(
                                Icons.arrow_back_outlined,
                                color: AppColors.white,
                                size: 30,
                              ),
                            ),
                            SizedBox(width: size.width * 0.2),
                            const Text(
                              "Urgent Tasks",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.045),
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
                                          "Urgent Task Progress",
                                          style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "${successState.totalRegularTasksCompleted}/${successState.totalRegularTasks} task completed.",
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
                                        height: size.height * 0.073,
                                        width: size.height * 0.073,
                                        child: CircularProgressIndicator(
                                          value: (successState
                                                      .totalRegularTasksCompleted ==
                                                  0)
                                              ? 0
                                              : (successState
                                                      .totalRegularTasksCompleted /
                                                  successState
                                                      .totalRegularTasks),
                                          strokeWidth: 7,
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.green[400]),
                                          backgroundColor:
                                              AppColors.white.withOpacity(0.2),
                                          color: AppColors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.073,
                                        width: size.height * 0.073,
                                        child: Center(
                                          child: Text(
                                            (successState
                                                        .totalUrgentTasksCompleted ==
                                                    0)
                                                ? "0%"
                                                : "${((successState.totalRegularTasksCompleted / successState.totalRegularTasks) * 100).toStringAsFixed(1)}%",
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
                        SizedBox(height: size.height * 0.03),
                        const Text(
                          "Regular Tasks",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Task(
                            task: successState.regularTasks[index],
                            bloc: homeBloc,
                          ),
                          itemCount: successState.totalRegularTasks,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 15);
                          },
                        ),
                        SizedBox(height: size.height * 0.04),
                      ],
                    ),
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
