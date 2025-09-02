import 'package:todo/core/resources/datastate.dart';
import 'package:todo/core/resources/usecases.dart';
import 'package:todo/features/auth/domain/repositories/user_repository.dart';

class SignoutUsecase extends Usecases<Datastate<bool>,Null>{
  final UserRepository _userRepository;

  SignoutUsecase(this._userRepository);

  @override
  Future<Datastate<bool>> call(Null params) {
    return _userRepository.signOut();
  }
}
