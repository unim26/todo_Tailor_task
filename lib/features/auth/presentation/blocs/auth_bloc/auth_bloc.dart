
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/resources/datastate.dart';
import 'package:todo/features/auth/domain/usecases/check_for_new_user_usecase.dart';
import 'package:todo/features/auth/domain/usecases/create_user_usecase.dart';
import 'package:todo/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:todo/features/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:todo/features/auth/domain/usecases/signout_usecase.dart';
import 'package:todo/features/auth/presentation/blocs/auth_bloc/auth_events.dart';
import 'package:todo/features/auth/presentation/blocs/auth_bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvents, UserAuthState> {
  //usecases
  final LoginWithGoogleUsecase _loginWithGoogleUsecase;
  final SignoutUsecase _signoutUsecase;
  final GetCurrentUserUsecase _getCurrentUserUsecase;
  final CheckForNewUserUsecase _checkForNewUserUsecase;
  final CreateUserUsecase _createUserUsecase;

  //constructure
  AuthBloc(
    this._loginWithGoogleUsecase,
    this._signoutUsecase,
    this._checkForNewUserUsecase,
    this._createUserUsecase,
    this._getCurrentUserUsecase,
  ) : super(AuthInitialState()) {
    //
    on<SignInWithGoogleEvent>(onSignInEventCall);
    //
    on<SignOutEvent>(onSignOutEventCall);
    //
    on<GetCurrentUserEvent>(onGetCurrentUserEventCall);
    //
    on<IsNewUserEvent>(onIsNewUserEventCall);

    //
    on<CreateNewUserEvent>(onCreateNewUserEvent);
  }

  //on sign in event call
  void onSignInEventCall(
    SignInWithGoogleEvent event,
    Emitter<UserAuthState> emit,
  ) async {
    //emit loading state
    emit(AuthLoadingState());

    //call api
    final datastate = await _loginWithGoogleUsecase.call(null);

    //check
    if (datastate is DataSuccess) {
      emit(AuthSuccessState(null, datastate.data));
    }

    if (datastate is DataFailed) {
      emit(AuthErrorState(datastate.message!));
    }
  }

  //on signout event call
  void onSignOutEventCall(SignOutEvent event, Emitter<UserAuthState> emit) async {
    //loading state
    emit(AuthLoadingState());

    //call api
    final datastate = await _signoutUsecase.call(null);

    //check
    if (datastate is DataSuccess) {
      emit(AuthSignOutState());
    }

    if (datastate is DataFailed) {
      emit(AuthErrorState(datastate.message!));
    }
  }

  //on get current user event call
  void onGetCurrentUserEventCall(
    GetCurrentUserEvent event,
    Emitter<UserAuthState> emit,
  ) async {
    //loading state
    emit(AuthLoadingState());

    //call api
    final datastate = await _getCurrentUserUsecase.call(null);

    //check
    if (datastate is DataSuccess) {
      print('data: ${datastate.data}');
      emit(AuthSuccessState(datastate.data, null));
    }
  }

  //on is new user event call
  void onIsNewUserEventCall(
    IsNewUserEvent event,
    Emitter<UserAuthState> emit,
  ) async {
    //loading state
    emit(AuthLoadingState());

    //call api
    final datastate = await _checkForNewUserUsecase.call(null);

    //check
    if (datastate is DataSuccess) {
      emit(AuthSuccessState(null, datastate.data));
    }

    if (datastate is DataFailed) {
      emit(AuthErrorState(datastate.message!));
    }
  }

  //on create new user event call
  void onCreateNewUserEvent(
    CreateNewUserEvent event,
    Emitter<UserAuthState> emit,
  ) async {
    //loading state
    emit(AuthLoadingState());

    //call api
    final datastate = await _createUserUsecase.call(event.user);

    //check
    if (datastate is DataSuccess) {
      emit(AuthSuccessState(null, datastate.data));
    }

    if (datastate is DataFailed) {
      emit(AuthErrorState(datastate.message!));
    }
  }
}
