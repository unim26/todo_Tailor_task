import 'package:equatable/equatable.dart';
import 'package:get/get_connect.dart';
import 'package:todo/features/todo/data/models/todo_model.dart';

abstract class TodoState extends Equatable{
  //variable
  final bool? response;
  final List<TodoModel>? todos;
  final String? errorMessage;

  //constructor
  const TodoState({this.errorMessage, this.response, this.todos});

  //prop
  @override
  List<Object?> get props => [errorMessage,todos,response];
}


//intial state
class TodoInitialState extends TodoState {
  const TodoInitialState();
}

//loading state
class TodoLoadingState extends TodoState {
  const TodoLoadingState();
}

//success state
class TodoSuccessState extends TodoState {
  const TodoSuccessState(List<TodoModel>? todos, bool? response)
    : super(errorMessage: null, todos: todos, response: response);
}

//error state
class TodoErrorState extends TodoState {
  const TodoErrorState(String errorMessage)
    : super(errorMessage: errorMessage, todos: null, response: null);
}

