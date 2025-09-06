import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:todo/core/utils/components/app_button.dart';
import 'package:todo/core/utils/components/app_loading_indicator.dart';
import 'package:todo/core/utils/components/app_snacbar.dart';
import 'package:todo/core/utils/components/app_text_field.dart';
import 'package:todo/features/todo/data/models/todo_model.dart';
import 'package:todo/features/todo/presentation/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo/features/todo/presentation/blocs/todo_bloc/todo_event.dart';
import 'package:todo/features/todo/presentation/blocs/todo_bloc/todo_state.dart';

class CreateTodoPage extends StatefulWidget {
  const CreateTodoPage({super.key});

  //text editing controllers
  static final TextEditingController todoTitleController =
      TextEditingController();

  @override
  State<CreateTodoPage> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  //variable
  TimeOfDay? selectedTime = null;

  //handle time picker
  Future<TimeOfDay?> _pickime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: (TimeOfDay.now().hour + 1) % 24,
        minute: TimeOfDay.now().minute,
      ),
      initialEntryMode: TimePickerEntryMode.dialOnly,
      confirmText: 'Add',
      cancelText: 'Cancel',
    );

    if (pickedTime != null) {
      return pickedTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sSize = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          //error state
          if (state is TodoErrorState) {
            //show error snackbar
            appSnacBar(context, message: state.errorMessage, type: 'warning');
          }

          //success state
          if (state is TodoSuccessState) {
            //show success snackbar
            appSnacBar(
              context,

              message: 'Todo added successfully',
              type: 'success',
            );
            //navigate to home page
            Get.offAllNamed('/');
          }
        },
        builder: (context, state) {
          //loading state
          if (state is TodoLoadingState) {
            return Center(
              child: AppLoadingIndicator(message: 'Adding Todo....'),
            );
          }

          //user profile build page
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  //space
                  SizedBox(height: sSize.height * 0.05),
                  //text
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Add Todo",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),

                  //space
                  SizedBox(height: sSize.height * 0.05),

                  //name field
                  AppTextField(
                    controller: CreateTodoPage.todoTitleController,
                    keyboardType: TextInputType.name,
                    hintText: 'Enter Todo title',
                  ),

                  //space
                  SizedBox(height: sSize.height * 0.025),

                  //selected time
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'deadline: ${selectedTime == null ? 'Not set' : selectedTime!.format(context)}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),

                  //space
                  SizedBox(height: sSize.height * 0.05),

                  //submit button
                  AppButton(
                    title: selectedTime == null ? 'Pick Time' : 'Submit',
                    onPressed: () {
                      if (selectedTime == null) {
                        _pickime(context).then((value) {
                          setState(() {
                            selectedTime = value;
                          });
                        });
                      } else {
                        if (CreateTodoPage.todoTitleController.text.isEmpty) {
                          //show error snackbar
                          appSnacBar(
                            context,
                            message: 'Please enter todo title',
                            type: 'warning',
                          );
                          return;
                        } else if (selectedTime == null) {
                          //show error snackbar
                          appSnacBar(
                            context,
                            message: 'Please select deadline time',
                            type: 'warning',
                          );
                          return;
                        }

                        //create todo model
                        final todo = TodoModel(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          title: CreateTodoPage.todoTitleController.text,
                          isCompleted: false,
                          deadline: selectedTime!.format(context),
                        );

                        //add todo event
                        BlocProvider.of<TodoBloc>(
                          context,
                        ).add(AddTodoEvent(todo: todo));

                        CreateTodoPage.todoTitleController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
