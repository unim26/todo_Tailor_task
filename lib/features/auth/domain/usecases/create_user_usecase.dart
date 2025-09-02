import 'package:todo/core/resources/datastate.dart';
import 'package:todo/core/resources/usecases.dart';
import 'package:todo/features/auth/data/models/user_model.dart';
import 'package:todo/features/auth/domain/repositories/user_repository.dart';

class CreateUserUsecase extends Usecases<Datastate<bool>,UserModel> {
  final UserRepository _userRepository;

  CreateUserUsecase(this._userRepository);

 @override
  Future<Datastate<bool>> call(UserModel params) {
    return _userRepository.createUser(params);
  }
}
