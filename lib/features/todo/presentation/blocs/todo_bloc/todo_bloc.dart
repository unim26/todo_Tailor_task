import 'package:bloc/bloc.dart';
import 'package:todo/core/resources/datastate.dart';
import 'package:todo/features/auth/presentation/blocs/auth_bloc/auth_state.dart';
import 'package:todo/features/todo/domain/usecases/add_todo_usecase.dart';
import 'package:todo/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:todo/features/todo/domain/usecases/get_todo_usecase.dart';
import 'package:todo/features/todo/domain/usecases/toggle_todo_complition_usecase.dart';
import 'package:todo/features/todo/domain/usecases/update_todo_usecase.dart';
import 'package:todo/features/todo/presentation/blocs/todo_bloc/todo_event.dart';
import 'package:todo/features/todo/presentation/blocs/todo_bloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  //use cases
  final GetTodoUsecase _getTodoUsecase;
  final AddTodoUsecase _addTodoUsecase;
  final ToggleTodoComplitionUsecase _toggleTodoComplitionUsecase;
  final DeleteTodoUsecase _deleteTodoUsecase;
  final UpdateTodoUsecase _updateTodoUsecase;

  //constructor
  TodoBloc(
    this._addTodoUsecase,
    this._deleteTodoUsecase,
    this._getTodoUsecase,
    this._toggleTodoComplitionUsecase,
    this._updateTodoUsecase,
  ) : super(TodoInitialState()) {
    //
    on<GetTodosEvent>(onGetTodosEventCall);
    //
    on<AddTodoEvent>(onAddtodoeventCall);
    //
    on<ToggleTodoStatusEvent>(onToggleTodoStatusEvent);
    //
    on<DeleteTodoEvent>(onDeleteTodoEventCall);
    //
    on<UpdateTodoEvent>(onUpdateTodoEventCall);
  }

  //on get todos event call
  void onGetTodosEventCall(GetTodosEvent event, Emitter<TodoState> emit) async {
    //loading
    emit(TodoLoadingState());

    //call api
    final datastate = await _getTodoUsecase.call(null);

    //check
    if (datastate is DataSuccess) {
      emit(TodoSuccessState(datastate.data, null));
    }

    if (datastate is DataFailed) {
      emit(TodoErrorState(datastate.message!));
    }
  }

  //on update todo event call
  void onUpdateTodoEventCall(
    UpdateTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    //loading state
    emit(TodoLoadingState());

    //call api
    final datastate = await _updateTodoUsecase.call({
      'id': event.id,
      'newTodo': event.newTodo,
    });

    //check
    if (datastate is DataSuccess) {
      emit(TodoSuccessState(state.todos, datastate.data));
    }

    if (datastate is DataFailed) {
      emit(TodoErrorState(datastate.message!));
    }
  }

  //on delete todo event call
  void onDeleteTodoEventCall(
    DeleteTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    // //loading
    // emit(TodoLoadingState());

    //call api
    final datastate = await _deleteTodoUsecase.call(event.id);

    //check
    if (datastate is DataSuccess) {
      final d = await _getTodoUsecase.call(null);
      emit(TodoSuccessState(d.data, datastate.data));
    }

    if (datastate is DataFailed) {
      emit(TodoErrorState(datastate.message!));
    }
  }

  //on toggle todo status event call
  void onToggleTodoStatusEvent(
    ToggleTodoStatusEvent event,
    Emitter<TodoState> emit,
  ) async {
    // //loading state
    // emit(TodoLoadingState());

    //call api
    final datastate = await _toggleTodoComplitionUsecase.call({
      'id': event.id,
      'value': event.value,
    });

    //check
    if (datastate is DataSuccess) {
      final d = await _getTodoUsecase.call(null);
      emit(TodoSuccessState(d.data, datastate.data));
    }

    if (datastate is DataFailed) {
      emit(TodoErrorState(datastate.message!));
    }
  }

  //on add todo event call
  void onAddtodoeventCall(AddTodoEvent event, Emitter<TodoState> emit) async {
    //loading state
    emit(TodoLoadingState());

    //call api
    final datastate = await _addTodoUsecase.call(event.todo);

    //check
    if (datastate is DataSuccess) {
      final d = await _getTodoUsecase.call(null);
      emit(TodoSuccessState(d.data, datastate.data));
    }

    if (datastate is DataFailed) {
      emit(TodoErrorState(datastate.message!));
    }
  }
}
