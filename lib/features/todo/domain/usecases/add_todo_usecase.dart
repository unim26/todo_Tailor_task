import 'package:todo/core/resources/datastate.dart';
import 'package:todo/core/resources/usecases.dart';
import 'package:todo/features/todo/data/models/todo_model.dart';
import 'package:todo/features/todo/domain/repositories/todo_repository.dart';

class AddTodoUsecase extends Usecases<Datastate<bool>, TodoModel> {
  //todo repo
  final TodoRepository _todoRepository;

  //constructor
  AddTodoUsecase(this._todoRepository);

  @override
  Future<Datastate<bool>> call(TodoModel params) {
    return _todoRepository.addTodo(params);
  }
}
