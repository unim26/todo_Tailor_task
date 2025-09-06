//locator
import 'package:get_it/get_it.dart';
import 'package:todo/features/auth/data/data_services/user_data_service.dart';
import 'package:todo/features/auth/data/repositories_impl/user_repository_impl.dart';
import 'package:todo/features/auth/domain/repositories/user_repository.dart';
import 'package:todo/features/auth/domain/usecases/check_for_new_user_usecase.dart';
import 'package:todo/features/auth/domain/usecases/create_user_usecase.dart';
import 'package:todo/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:todo/features/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:todo/features/auth/domain/usecases/signout_usecase.dart';
import 'package:todo/features/auth/domain/usecases/update_fcm_token_usecase.dart';
import 'package:todo/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:todo/features/auth/presentation/blocs/auth_bloc/auth_events.dart';
import 'package:todo/features/todo/data/data_source/todo_data_services.dart';
import 'package:todo/features/todo/data/repositories_impl/todo_repository_impl.dart';
import 'package:todo/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo/features/todo/domain/usecases/add_todo_usecase.dart';
import 'package:todo/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:todo/features/todo/domain/usecases/get_todo_usecase.dart';
import 'package:todo/features/todo/domain/usecases/toggle_todo_complition_usecase.dart';
import 'package:todo/features/todo/domain/usecases/update_todo_usecase.dart';
import 'package:todo/features/todo/presentation/blocs/todo_bloc/todo_bloc.dart';

final locator = GetIt.instance;

void initLocator() {
  //=============================== data serviceses================================//
  locator.registerLazySingleton<UserDataService>(() => UserDataService());
  locator.registerLazySingleton<TodoDataServices>(() => TodoDataServices());

  //=============================== repositories================================//
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(locator<UserDataService>()),
  );
  locator.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(locator<TodoDataServices>()),
  );

  //=============================== usecases================================//
  locator.registerLazySingleton<CheckForNewUserUsecase>(
    () => CheckForNewUserUsecase(locator<UserRepository>()),
  );
  locator.registerLazySingleton<CreateUserUsecase>(
    () => CreateUserUsecase(locator<UserRepository>()),
  );
  locator.registerLazySingleton<GetCurrentUserUsecase>(
    () => GetCurrentUserUsecase(locator<UserRepository>()),
  );
  locator.registerLazySingleton<LoginWithGoogleUsecase>(
    () => LoginWithGoogleUsecase(locator<UserRepository>()),
  );
  locator.registerLazySingleton<SignoutUsecase>(
    () => SignoutUsecase(locator<UserRepository>()),
  );

  locator.registerLazySingleton<AddTodoUsecase>(
    () => AddTodoUsecase(locator<TodoRepository>()),
  );
  locator.registerLazySingleton<DeleteTodoUsecase>(
    () => DeleteTodoUsecase(locator<TodoRepository>()),
  );
  locator.registerLazySingleton<GetTodoUsecase>(
    () => GetTodoUsecase(locator<TodoRepository>()),
  );
  locator.registerLazySingleton<ToggleTodoComplitionUsecase>(
    () => ToggleTodoComplitionUsecase(locator<TodoRepository>()),
  );
  locator.registerLazySingleton<UpdateTodoUsecase>(
    () => UpdateTodoUsecase(locator<TodoRepository>()),
  );
  locator.registerLazySingleton<UpdateFcmTokenUsecase>(
    () => UpdateFcmTokenUsecase(locator<UserRepository>()),
  );


  //=============================== blocs================================//
  locator.registerFactory(
    () => AuthBloc(
      locator<LoginWithGoogleUsecase>(),
      locator<SignoutUsecase>(),
      locator<CheckForNewUserUsecase>(),
      locator<CreateUserUsecase>(),
      locator<GetCurrentUserUsecase>(),
    ),
  );

  locator.registerFactory(() => TodoBloc(
    locator<AddTodoUsecase>(),
    locator<DeleteTodoUsecase>(),
    locator<GetTodoUsecase>(),
    locator<ToggleTodoComplitionUsecase>(),
    locator<UpdateTodoUsecase>(),
  ));
}
