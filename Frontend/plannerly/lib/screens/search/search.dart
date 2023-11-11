import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plannerly/bloc/home/home_bloc.dart';
import 'package:plannerly/screens/widgets/task.dart';
import 'package:plannerly/utils/colors/colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String search = "";
  HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      bloc: homeBloc,
      listener: (context, state) {
        if (state is HomePopState) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case SearchLoadingState:
            return Scaffold(
              backgroundColor: AppColors.backgroundDark,
              body: SingleChildScrollView(
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
                              homeBloc
                                  .add(HomeAddNewTaskCloseButtonClickedEvent());
                            },
                            icon: const Icon(
                              Icons.arrow_back_outlined,
                              color: AppColors.white,
                              size: 30,
                            ),
                          ),
                          SizedBox(width: size.width * 0.2),
                          const Text(
                            "Search Tasks",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.025),
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
                                Expanded(
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search task',
                                      hintStyle: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: 18,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                    onSubmitted: (value) {
                                      homeBloc.add(SearchForTasksEvent(
                                          searchString: value));
                                    },
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
                      SizedBox(height: size.height * 0.045),
                      const Text(
                        "Urgent Tasks",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: size.height * 0.04),
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                      SizedBox(height: size.height * 0.04),
                      const Text(
                        "Regular Tasks",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: size.height * 0.04),
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                      SizedBox(height: size.height * 0.04),
                    ],
                  ),
                ),
              ),
            );
          case SearchSuccessState:
            var successState = state as SearchSuccessState;
            return Scaffold(
              backgroundColor: AppColors.backgroundDark,
              body: SingleChildScrollView(
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
                              homeBloc
                                  .add(HomeAddNewTaskCloseButtonClickedEvent());
                            },
                            icon: const Icon(
                              Icons.arrow_back_outlined,
                              color: AppColors.white,
                              size: 30,
                            ),
                          ),
                          SizedBox(width: size.width * 0.2),
                          const Text(
                            "Search Tasks",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.025),
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
                                Expanded(
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search task',
                                      hintStyle: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: 18,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                    onSubmitted: (value) {
                                      homeBloc.add(SearchForTasksEvent(
                                          searchString: value));
                                    },
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

                      SizedBox(height: size.height * 0.045),
                      // Center(
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: AppColors.backgroundLight,
                      //       borderRadius: BorderRadius.circular(18),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(18.0),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Expanded(
                      //             child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 const Text(
                      //                   "Urgent Task Progress",
                      //                   style: TextStyle(
                      //                     color: AppColors.white,
                      //                     fontSize: 20,
                      //                     fontWeight: FontWeight.w400,
                      //                   ),
                      //                 ),
                      //                 const SizedBox(height: 8),
                      //                 // Text(
                      //                 //   "${successState.totalRegularTasksCompleted}/${successState.totalRegularTasks} task completed.",
                      //                 //   style: TextStyle(
                      //                 //     color: AppColors.white
                      //                 //         .withOpacity(0.4),
                      //                 //     fontSize: 14,
                      //                 //     fontWeight: FontWeight.w400,
                      //                 //   ),
                      //                 // ),
                      //               ],
                      //             ),
                      //           ),
                      //           Stack(
                      //             children: [
                      //               // SizedBox(
                      //               //   height: size.height * 0.073,
                      //               //   width: size.height * 0.073,
                      //               //   child: CircularProgressIndicator(
                      //               //     value: (successState
                      //               //                 .totalRegularTasksCompleted ==
                      //               //             0)
                      //               //         ? 0
                      //               //         : (successState
                      //               //                 .totalRegularTasksCompleted /
                      //               //             successState
                      //               //                 .totalRegularTasks),
                      //               //     strokeWidth: 7,
                      //               //     valueColor: AlwaysStoppedAnimation(
                      //               //         Colors.green[400]),
                      //               //     backgroundColor:
                      //               //         AppColors.white.withOpacity(0.2),
                      //               //     color: AppColors.white,
                      //               //   ),
                      //               // ),
                      //               // SizedBox(
                      //               //   height: size.height * 0.073,
                      //               //   width: size.height * 0.073,
                      //               //   child: Center(
                      //               //     child: Text(
                      //               //       (successState
                      //               //                   .totalUrgentTasksCompleted ==
                      //               //               0)
                      //               //           ? "0%"
                      //               //           : "${((successState.totalRegularTasksCompleted / successState.totalRegularTasks) * 100).toStringAsFixed(1)}%",
                      //               //       style: TextStyle(
                      //               //         color: AppColors.white
                      //               //             .withOpacity(0.8),
                      //               //         fontSize: 18,
                      //               //         fontWeight: FontWeight.w600,
                      //               //       ),
                      //               //     ),
                      //               //   ),
                      //               // ),
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: size.height * 0.03),
                      const Text(
                        "Urgent Tasks",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (successState.urgTasks.isNotEmpty)
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Task(
                            task: successState.urgTasks[index],
                            bloc: homeBloc,
                          ),
                          itemCount: successState.urgTasks.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 15);
                          },
                        ),
                      if (successState.urgTasks.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 16.0),
                            child: Text(
                              'No tasks present!!',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: size.height * 0.04),
                      const Text(
                        "Regular Tasks",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (successState.regTasks.isNotEmpty)
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Task(
                            task: successState.regTasks[index],
                            bloc: homeBloc,
                          ),
                          itemCount: successState.regTasks.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 15);
                          },
                        ),
                      if (successState.regTasks.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 16.0),
                            child: Text(
                              'No tasks present!!',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: size.height * 0.04),
                    ],
                  ),
                ),
              ),
            );
          case SearchErrorState:
            var s = state as SearchErrorState;
            return Scaffold(
              backgroundColor: AppColors.backgroundDark,
              body: SingleChildScrollView(
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
                              homeBloc
                                  .add(HomeAddNewTaskCloseButtonClickedEvent());
                            },
                            icon: const Icon(
                              Icons.arrow_back_outlined,
                              color: AppColors.white,
                              size: 30,
                            ),
                          ),
                          SizedBox(width: size.width * 0.2),
                          const Text(
                            "Search Tasks",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.025),
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
                                Expanded(
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search task',
                                      hintStyle: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: 18,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                    onSubmitted: (value) {
                                      homeBloc.add(SearchForTasksEvent(
                                          searchString: value));
                                    },
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
                      SizedBox(height: size.height * 0.03),
                      SizedBox(
                        width: size.width * 0.8,
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 25,
                              color: Colors.red[400],
                            ),
                            const SizedBox(width: 5),
                            Center(
                              child: SizedBox(
                                width: size.width * 0.7,
                                child: Text(
                                  s.message,
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      const Text(
                        "Urgent Tasks",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: size.height * 0.04),
                      const Text(
                        "Regular Tasks",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: size.height * 0.04),
                    ],
                  ),
                ),
              ),
            );
          default:
            return Scaffold(
              backgroundColor: AppColors.backgroundDark,
              body: RefreshIndicator(
                onRefresh: () async {
                  // homeBloc.add(HomeInitialEvent());
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
                              "Search Tasks",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.025),
                        Center(
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
                                  Expanded(
                                    child: TextField(
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Search task',
                                        hintStyle: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: 18,
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                      onSubmitted: (value) {
                                        homeBloc.add(SearchForTasksEvent(
                                            searchString: value));
                                      },
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
                        SizedBox(height: size.height * 0.045),
                        const Text(
                          "Urgent Tasks",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
                        const Text(
                          "Regular Tasks",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
                      ],
                    ),
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
