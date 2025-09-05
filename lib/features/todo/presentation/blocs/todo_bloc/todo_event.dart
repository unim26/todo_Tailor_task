import 'package:todo/features/todo/data/models/todo_model.dart';

abstract class TodoEvent {
  const TodoEvent();
}

//get todos event
class GetTodosEvent extends TodoEvent {
  const GetTodosEvent();
}

//add todo event
class AddTodoEvent extends TodoEvent {
  final TodoModel todo;

  const AddTodoEvent({required this.todo});
}

//toggle todo status event
class ToggleTodoStatusEvent extends TodoEvent {
  final dynamic id;
  final bool value;

  const ToggleTodoStatusEvent({required this.id, required this.value});
}

//delete todo event
class DeleteTodoEvent extends TodoEvent {
  final dynamic id;

  const DeleteTodoEvent({required this.id});
}

//update todo event
class UpdateTodoEvent extends TodoEvent {
  final dynamic id;
  final TodoModel newTodo;

  const UpdateTodoEvent({required this.id, required this.newTodo});
}
