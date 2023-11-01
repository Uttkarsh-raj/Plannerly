import 'dart:convert';

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

  TaskModel copyWith({
    String? taskId,
    String? userId,
    String? title,
    String? description,
    String? time,
    String? date,
    bool? completed,
    bool? urgent,
  }) {
    return TaskModel(
      taskId: taskId ?? this.taskId,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
      date: date ?? this.date,
      completed: completed ?? this.completed,
      urgent: urgent ?? this.urgent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskId': taskId,
      'userId': userId,
      'title': title,
      'description': description,
      'time': time,
      'date': date,
      'completed': completed,
      'urgent': urgent,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskId: map['taskId'] as String,
      userId: map['userId'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      time: map['time'] as String,
      date: map['date'] as String,
      completed: map['completed'] as bool,
      urgent: map['urgent'] as bool,
    );
  }

  @override
  String toString() {
    return 'TaskModel(taskId: $taskId, userId: $userId, title: $title, description: $description, time: $time, date: $date, completed: $completed, urgent: $urgent)';
  }

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.taskId == taskId &&
        other.userId == userId &&
        other.title == title &&
        other.description == description &&
        other.time == time &&
        other.date == date &&
        other.completed == completed &&
        other.urgent == urgent;
  }
}
