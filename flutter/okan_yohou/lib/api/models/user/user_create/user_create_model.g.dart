// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_create_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCreateModel _$UserCreateModelFromJson(Map<String, dynamic> json) {
  return UserCreateModel(
    token: json['token'] as String?,
    name: json['name'] as String?,
    email: json['email'] as String?,
    birthday: json['birthday'] as String?,
    gender: json['gender'] as int?,
    residence: json['residence'] as int?,
    password: json['password'] as String?,
    gamistory: json['gamistory'] as String?,
  );
}

Map<String, dynamic> _$UserCreateModelToJson(UserCreateModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'name': instance.name,
      'email': instance.email,
      'birthday': instance.birthday,
      'gender': instance.gender,
      'residence': instance.residence,
      'password': instance.password,
      'gamistory': instance.gamistory,
    };
