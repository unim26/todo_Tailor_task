import 'package:todo/core/resources/datastate.dart';
import 'package:todo/core/resources/usecases.dart';
import 'package:todo/features/auth/domain/entities/user_entity.dart';
import 'package:todo/features/auth/domain/repositories/user_repository.dart';

class GetCurrentUserUsecase extends Usecases<Datastate<UserEntity>, Null> {
  final UserRepository _userRepository;

  GetCurrentUserUsecase(this._userRepository);

  @override
  Future<Datastate<UserEntity>> call(Null params) {
    return _userRepository.getCurrentUser();
  }
}
