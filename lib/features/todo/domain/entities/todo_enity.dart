import 'package:equatable/equatable.dart';

class TodoEnity extends Equatable {
  //variables
  final dynamic id;
  final dynamic userId;
  final String? title;
  final bool? isCompleted;
  final String deadline;

  //constructer
  const TodoEnity({
    required this.id,
    required this.userId,
    required this.title,
    required this.isCompleted,
    required this.deadline,
  });

  //props
  @override
  List<Object?> get props => [id,userId,title, isCompleted, deadline];
}
