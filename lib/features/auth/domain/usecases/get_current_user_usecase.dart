import 'package:todo/core/resources/datastate.dart';
import 'package:todo/core/resources/usecases.dart';
import 'package:todo/features/auth/data/models/user_model.dart';
import 'package:todo/features/auth/domain/entities/user_entity.dart';
import 'package:todo/features/auth/domain/repositories/user_repository.dart';

class GetCurrentUserUsecase extends Usecases<Datastate<UserModel>, Null> {
  final UserRepository _userRepository;

  GetCurrentUserUsecase(this._userRepository);

  @override
  Future<Datastate<UserModel>> call(Null params) {
    return _userRepository.getCurrentUser();
  }
}
