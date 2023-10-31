// ignore_for_file: public_member_api_docs, sort_constructors_first
class TaskModel {
  final String taskId;
  final String userId;
  final String title;
  final String description;
  final String time;
  final String date;
  final bool completed;
  final bool urgent;
  TaskModel({
    required this.taskId,
    required this.userId,
    required this.title,
    required this.description,
    required this.time,
    required this.date,
    required this.completed,
    required this.urgent,
  });
}
