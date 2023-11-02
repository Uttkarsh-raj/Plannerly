import 'package:flutter/material.dart';
import 'package:plannerly/bloc/home/home_bloc.dart';
import 'package:plannerly/models/task_model.dart';

import '../../utils/colors/colors.dart';

class Task extends StatefulWidget {
  const Task({super.key, required this.task, required this.bloc});
  final TaskModel task;
  final HomeBloc bloc;
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
          padding: const EdgeInsets.all(10.0).copyWith(top: 15, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  if (!widget.task.completed) {
                    widget.bloc.add(
                      HomeTasksCompletedButtonClicked(
                        taskCompleted: widget.task,
                      ),
                    );
                  }
                },
                icon: (!widget.task.completed)
                    ? Icon(
                        Icons.done_outline,
                        color: AppColors.white.withOpacity(0.3), //Colors.green
                        size: 30,
                      )
                    : const Icon(
                        Icons.done_rounded,
                        color: Colors.green, //Colors.green
                        size: 40,
                      ),
              ),
              SizedBox(width: size.width * 0.06),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      // "description: task description here.",
                      widget.task.description,
                      maxLines: 3,
                      style: TextStyle(
                        color: AppColors.white.withOpacity(0.4),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "date: ${widget.task.date}   time: ${widget.task.time}",
                      style: TextStyle(
                        color: AppColors.white.withOpacity(0.4),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  widget.bloc.add(
                    HomeTasksDeleteButtonClicked(
                      taskDeleted: widget.task,
                    ),
                  );
                  widget.bloc.add(HomeInitialEvent());
                },
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.red[400],
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
