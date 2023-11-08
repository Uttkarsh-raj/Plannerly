import 'package:flutter/material.dart';
import 'package:plannerly/utils/colors/colors.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  List<String> names = ["Home", "Urgent Tasks", "Regular Tasks"];
  List<IconData> icons = [
    Icons.home_outlined,
    Icons.task_alt_outlined,
    Icons.task_outlined
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
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {},
                      leading: Icon(icons[index]),
                      title: Text(
                        names[index],
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 3),
                ),
              ),
              ListTile(
                onTap: () {},
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
