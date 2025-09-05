
import 'package:todo/core/resources/datastate.dart';
import 'package:todo/core/resources/usecases.dart';
import 'package:todo/features/todo/domain/repositories/todo_repository.dart';

class UpdateTodoUsecase extends Usecases<Datastate<bool>, Map<String,dynamic>> {
  //todo repo
  final TodoRepository _todoRepository;

  //constructor
  UpdateTodoUsecase(this._todoRepository);

  @override
  Future<Datastate<bool>> call(Map<String,dynamic> params) {
    return _todoRepository.updateTodo(params['id'],params['newTodo']);
  }
}
