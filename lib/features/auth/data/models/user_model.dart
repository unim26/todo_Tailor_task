import 'package:todo/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {

  //construcor
  const UserModel({
    super.id,
    super.fcmToken,
    required super.email,
    required super.name,
    super.photoUrl,
  });


  //from json method
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    fcmToken: json['fcm_token'],
    email: json['email'] ?? '',
    name: json['name'] ?? '',
    photoUrl: json['photo_url'] ?? '',
  );

  //tojson method
  Map<String, dynamic> toJson() => {
    'id': id,
    'fcm_token': fcmToken,
    'email': email,
    'name': name,
    'photo_url': photoUrl,
  };
}
