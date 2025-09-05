import 'package:todo/core/resources/datastate.dart';
import 'package:todo/features/todo/data/data_source/todo_data_services.dart';
import 'package:todo/features/todo/data/models/todo_model.dart';
import 'package:todo/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  //todo data service
  final TodoDataServices _todoDataServices;

  //constructor
  TodoRepositoryImpl(this._todoDataServices);

  //add todos
  @override
  Future<Datastate<bool>> addTodo(TodoModel todo) async {
    try {
      final response = await _todoDataServices.addTodo(todo);

      if (response) {
        return DataSuccess(true);
      } else {
        return DataFailed("something went wrong while creating user");
      }
    } catch (e) {
      print('Error adding todo: $e');
      return DataFailed("something went wrong while adding todo");
    }
  }

  //delete todo
  @override
  Future<Datastate<bool>> deleteTodo(id) async {
    try {
      final response = await _todoDataServices.deleteTodo(id);

      if (response) {
        return DataSuccess(true);
      } else {
        return DataFailed("Something went wrong while deleting todo");
      }
    } catch (e) {
      print('Error in deleting todo: $e');
      return DataFailed("something went wrong while deleting todo");
    }
  }

  //get all todo
  @override
  Future<Datastate<List<TodoModel>>> getTodos() async {
    try {
      final response = await _todoDataServices.getTodos();

      if (response!.isNotEmpty) {
        final List<TodoModel> finalData =
            response.map((data) => TodoModel.fromJson(data)).toList();
        return DataSuccess(finalData);
      } else {
        return DataFailed("NO todo Available");
      }
    } catch (e) {
      print('Error while getting todo $e');
      return DataFailed('something went wrong while getting todos');
    }
  }

  @override
  Future<Datastate<bool>> toggleTodoCompletion(id, bool value) async {
    try {
      final response = await _todoDataServices.toggleTodoCompletion(id, value);

      if (response) {
        return DataSuccess(response);
      } else {
        return DataFailed('Something went wrong while toggling status');
      }
    } catch (e) {
      print('Error while toggling toso status $e');
      return DataFailed('Something went wrong while toggling status');
    }
  }

  @override
  Future<Datastate<bool>> updateTodo(id, TodoModel newTodo) async {
    try {
      final response = await _todoDataServices.updateTodo(id, newTodo);

      if (response) {
        return DataSuccess(response);
      } else {
        return DataFailed('Something went wrong while updating todo');
      }
    } catch (e) {
      print('Error while updating todo $e');
      return DataFailed('Something went wrong while updating todo');
    }
  }
}
