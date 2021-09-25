// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_patch_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPatchResponseModel _$UserPatchResponseModelFromJson(
    Map<String, dynamic> json) {
  return UserPatchResponseModel(
    type: json['type'] as String?,
    user: json['user'] == null
        ? null
        : UserModel.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserPatchResponseModelToJson(
        UserPatchResponseModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'user': instance.user,
    };
