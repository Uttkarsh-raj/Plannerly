import 'package:flutter/material.dart';
import 'package:plannerly/utils/colors/colors.dart';

class TaskFormField extends StatefulWidget {
  const TaskFormField(
      {super.key,
      required this.title,
      required this.hint,
      required this.controller,
      this.height,
      this.maxLines});
  final String title;
  final String hint;
  final TextEditingController controller;
  final double? height;
  final int? maxLines;

  @override
  State<TaskFormField> createState() => _TaskFormFieldState();
}

class _TaskFormFieldState extends State<TaskFormField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${widget.title} ",
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: size.width,
          height: (widget.height != 0) ? widget.height : size.height * 0.06,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: AppColors.grey,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: TextField(
              maxLines: (widget.maxLines != 0) ? widget.maxLines : 1,
              controller: widget.controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(10),
                hintText: widget.hint,
                hintStyle: TextStyle(
                  color: AppColors.white.withOpacity(0.8),
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
