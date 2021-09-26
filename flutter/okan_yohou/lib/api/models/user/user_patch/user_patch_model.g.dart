// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_patch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPatchModel _$UserPatchModelFromJson(Map<String, dynamic> json) {
  return UserPatchModel(
    photo: json['photo'] as String?,
    photoName: json['photoName'] as String?,
    introduction: json['introduction'] as String?,
    lock: json['lock'] as int?,
    residence: json['residence'] as int?,
    os: json['os'] as int?,
    username: json['username'] as String?,
    birthday: json['birthday'] as String?,
    gender: json['gender'] as int?,
    password: json['password'] as String?,
    fcmToken: json['fcm_token'] as String?,
    email: json['email'] as String?,
  );
}

Map<String, dynamic> _$UserPatchModelToJson(UserPatchModel instance) =>
    <String, dynamic>{
      'photo': instance.photo,
      'photoName': instance.photoName,
      'introduction': instance.introduction,
      'lock': instance.lock,
      'residence': instance.residence,
      'os': instance.os,
      'username': instance.username,
      'birthday': instance.birthday,
      'gender': instance.gender,
      'password': instance.password,
      'fcm_token': instance.fcmToken,
      'email': instance.email,
    };
