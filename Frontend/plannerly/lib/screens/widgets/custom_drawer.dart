import 'package:flutter/material.dart';
import 'package:plannerly/bloc/home/home_bloc.dart';
import 'package:plannerly/screens/home/home.dart';
import 'package:plannerly/utils/colors/colors.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key, required this.homeBloc});
  final HomeBloc homeBloc;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late List<ListTile> tiles = [
    ListTile(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      },
      leading: const Icon(Icons.home_outlined),
      title: const Text(
        "Home",
        style: TextStyle(
          color: AppColors.white,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
    ListTile(
      onTap: () {
        widget.homeBloc.add(HomeUrgentTasksViewAllClickedEvent());
      },
      leading: const Icon(Icons.task_alt_outlined),
      title: const Text(
        "Urgent Tasks",
        style: TextStyle(
          color: AppColors.white,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
    ListTile(
      onTap: () {
        widget.homeBloc.add(HomeRegularTasksViewAllClickedEvent());
      },
      leading: const Icon(Icons.task_outlined),
      title: const Text(
        "Regular Tasks",
        style: TextStyle(
          color: AppColors.white,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: AppColors.backgroundDark,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.2,
                    child: Image.asset(
                      'assets/images/logo_transparent.png',
                      scale: 3,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.45,
                    child: Image.asset(
                      'assets/images/plannerly.png',
                      scale: 3,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.separated(
                  itemCount: tiles.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return tiles[index];
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 3),
                ),
              ),
              ListTile(
                onTap: () {
                  widget.homeBloc.add(HomeLogoutButtonClickedEvent());
                },
                leading: const Icon(Icons.logout_outlined),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
