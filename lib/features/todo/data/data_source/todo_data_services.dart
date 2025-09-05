import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo/features/todo/data/models/todo_model.dart';

class TodoDataServices {
  //supabase client
  final SupabaseClient supabaseClient = Supabase.instance.client;

  //meyhod to get all todos
  Future<List<Map<String, dynamic>>?> getTodos() async {
    try {
      return await supabaseClient.from('Todos').select('*');
    } catch (e) {
      print('Error in getting todos: $e');
      return null;
    }
  }

  //method to add todos
  Future<bool> addTodo(TodoModel todo) async {
    try {
      await supabaseClient.from('Todos').insert(todo.toJson());

      return true;
    } catch (e) {
      print('Error in adding todo: $e');
      return false;
    }
  }

  //method to toggle todo status
  Future<bool> toggleTodoCompletion(dynamic id, bool value) async {
    try {
      await supabaseClient
          .from('Todos')
          .update({'isCompleted': value})
          .eq('id', id);

      return true;
    } catch (e) {
      print('Error in toogling status: $e');
      return false;
    }
  }

  //methdo to delete todo
  Future<bool> deleteTodo(dynamic id) async {
    try {
      await supabaseClient.from('Todos').delete().eq('id', id);

      return true;
    } catch (e) {
      print('Error in deleting todo: $e');
      return false;
    }
  }

  //update todo
  Future<bool> updateTodo(dynamic id, TodoModel newTodo) async {
    try {
      await supabaseClient.from('Todos').update(newTodo.toJson()).eq('id', id);

      return true;
    } catch (e) {
      print('Error in updating todo: $e');
      return false;
    }
  }
}
