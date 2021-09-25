// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_user_exist_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckUserExistResponseModel _$CheckUserExistResponseModelFromJson(
    Map<String, dynamic> json) {
  return CheckUserExistResponseModel(
    type: json['type'] as String?,
    userExist: json['user_exist'] as String?,
    user: json['user'] == null
        ? null
        : UserModel.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CheckUserExistResponseModelToJson(
        CheckUserExistResponseModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'user_exist': instance.userExist,
      'user': instance.user,
    };
