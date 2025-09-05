import 'package:todo/core/resources/datastate.dart';
import 'package:todo/core/resources/usecases.dart';
import 'package:todo/features/todo/domain/repositories/todo_repository.dart';

class DeleteTodoUsecase extends Usecases<Datastate<bool>, dynamic> {
  //todo repo
  final TodoRepository _todoRepository;

  //constructor
  DeleteTodoUsecase(this._todoRepository);

  @override
  Future<Datastate<bool>> call(dynamic params) {
    return _todoRepository.deleteTodo(params);
  }
}
