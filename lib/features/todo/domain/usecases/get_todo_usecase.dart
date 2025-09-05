import 'package:todo/core/resources/datastate.dart';
import 'package:todo/core/resources/usecases.dart';
import 'package:todo/features/todo/data/models/todo_model.dart';
import 'package:todo/features/todo/domain/repositories/todo_repository.dart';

class GetTodoUsecase extends Usecases<Datastate<List<TodoModel>>, Null> {
  //todo repo
  final TodoRepository _todoRepository;

  //constructor
  GetTodoUsecase(this._todoRepository);

  @override
  Future<Datastate<List<TodoModel>>> call(Null params) {
    return _todoRepository.getTodos();
  }
}
