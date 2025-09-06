import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo/features/todo/domain/entities/todo_enity.dart';

class TodoModel extends TodoEnity {
  //constructure
  const TodoModel({
    super.id,
    super.userId,
    required super.title,
    required super.isCompleted,
    required super.deadline,
  });

  //from json method
  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
    id: json['id'],
    userId: json['user_id'],
    title: json['title'] ?? '',
    isCompleted: json['is_completed'] ?? false,
    deadline: json['deadline'] ?? '',
  );

  //to json method
  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': _getCurrentUserId(),
    'title': title,
    'is_completed': isCompleted,
    'deadline': deadline,
  };

  //method to get current user id
  String? _getCurrentUserId() {
    return Supabase.instance.client.auth.currentUser?.id;
  }
}
