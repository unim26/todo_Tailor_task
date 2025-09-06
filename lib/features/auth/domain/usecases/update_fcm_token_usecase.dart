import 'package:todo/core/resources/datastate.dart';
import 'package:todo/core/resources/usecases.dart';
import 'package:todo/features/auth/domain/repositories/user_repository.dart';

class UpdateFcmTokenUsecase extends Usecases<Datastate<bool>,String>{

//user repository
final UserRepository _userRepository;

//constructure
UpdateFcmTokenUsecase(this._userRepository);

  @override
  Future<Datastate<bool>> call(String params) {
    return _userRepository.updateFcmToken(params);
  }


}

