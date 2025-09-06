import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo/core/utils/components/app_loading_indicator.dart';
import 'package:todo/core/utils/components/app_snacbar.dart';
import 'package:todo/dependency_injection.dart';
import 'package:todo/features/auth/data/data_services/user_data_service.dart';
import 'package:todo/features/auth/data/models/user_model.dart';
import 'package:todo/features/auth/domain/usecases/update_fcm_token_usecase.dart';
import 'package:todo/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:todo/features/auth/presentation/blocs/auth_bloc/auth_events.dart';
import 'package:todo/features/fcm/data/data_services/fcm_data_service.dart';
import 'package:todo/features/home/presentation/widgets/build_top_bar.dart';
import 'package:todo/features/todo/presentation/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo/features/todo/presentation/blocs/todo_bloc/todo_event.dart';
import 'package:todo/features/todo/presentation/blocs/todo_bloc/todo_state.dart';
import 'package:todo/features/todo/presentation/pages/create_todo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //varoables
  late UserModel user;
  final FcmDataService _fcmDataService = FcmDataService();
  final UpdateFcmTokenUsecase _updateFcmTokenUsecase =
      locator<UpdateFcmTokenUsecase>();

  //init fcm
  void _initFcm() async {
    final String? token = await _fcmDataService.initFcm(context);

    if (token != null) {
      //update user fcm token
      await _updateFcmTokenUsecase.call(token);

      //sign out user if token is null
    }
  }

  //init state
  @override
  void initState() {
    //init fcm

    _initFcm();

    final currentUser = Supabase.instance.client.auth.currentUser;
    user = UserModel(
      email: currentUser!.email!,
      name: currentUser.userMetadata!['full_name'],
      photoUrl: currentUser.userMetadata!['avatar_url'],
    );

    //get all todos of user
    context.read<TodoBloc>().add(GetTodosEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<TodoBloc, TodoState>(
          listener: (context, state) {
            //error state
            if (state is TodoErrorState) {
              appSnacBar(context, message: state.errorMessage, type: 'warning');
            }
          },
          builder: (context, state) {
            //loading state
            if (state is TodoLoadingState) {
              return AppLoadingIndicator(message: "getting your todos....!");
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //top bar
                    BuildTopBar(user: user),

                    //space
                    SizedBox(height: 20),

                    //text
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "TODOS",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),

                    //user todo list
                    Expanded(
                      child:
                          state.todos != null
                              ? ListView.builder(
                                itemCount: state.todos!.length,
                                itemBuilder: (context, index) {
                                  final todo = state.todos![index];
                                  return Card(
                                    child: ListTile(
                                      leading: Checkbox(
                                        value: todo.isCompleted,
                                        onChanged: (value) {
                                          //update todo
                                          context.read<TodoBloc>().add(
                                            ToggleTodoStatusEvent(
                                              id: todo.id,
                                              value: value!,
                                            ),
                                          );
                                        },
                                      ),
                                      title: Text(
                                        todo.title!,
                                        style: TextStyle(
                                          decoration:
                                              todo.isCompleted!
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,

                                          decorationThickness: 3,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "Deadline: ${todo.deadline}",
                                      ),
                                      trailing:
                                          todo.isCompleted!
                                              ? IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  //delete todo
                                                  context.read<TodoBloc>().add(
                                                    DeleteTodoEvent(
                                                      id: todo.id,
                                                    ),
                                                  );
                                                },
                                              )
                                              : null,
                                    ),
                                  );
                                },
                              )
                              : Center(
                                child: Text(
                                  "No todos found. Add some!",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        //floating button
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            //navigate to create todo page
            Get.toNamed('/create-todo-page');
          },
          label: Text("Add todo"),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}
