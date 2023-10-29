import 'package:flutter/material.dart';

import '../../utils/colors/colors.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
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
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.radio_button_off,
                    color: AppColors.white.withOpacity(0.3),
                    size: 30,
                  )),
              SizedBox(width: size.width * 0.06),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Title of the task",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "description: task description here.",
                      style: TextStyle(
                        color: AppColors.white.withOpacity(0.4),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "date: 22/12/2023   time: 10:00:00",
                      style: TextStyle(
                        color: AppColors.white.withOpacity(0.4),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
