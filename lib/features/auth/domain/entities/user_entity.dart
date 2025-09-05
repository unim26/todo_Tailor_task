import 'package:equatable/equatable.dart';

abstract class UserEntity extends Equatable {
  final dynamic id;
  final String email;
  final String name;
  final String? photoUrl;
  final String? fcmToken;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    this.fcmToken,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [id, email, name, photoUrl,fcmToken];
}
