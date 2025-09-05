import 'package:todo/core/resources/datastate.dart';
import 'package:todo/features/todo/data/models/todo_model.dart';
import 'package:todo/features/todo/domain/entities/todo_enity.dart';

abstract class TodoRepository {
  //method to get all todo
  Future<Datastate<List<TodoModel>>> getTodos();

  //method to add todo
  Future<Datastate<bool>> addTodo(TodoModel todo);

  //method to toggle completion todo status
  Future<Datastate<bool>> toggleTodoCompletion(dynamic id,bool value);

  //method to delete todo
  Future<Datastate<bool>> deleteTodo(dynamic id);

  //method to update todo
  Future<Datastate<bool>> updateTodo(dynamic id,TodoModel newTodo);
}
