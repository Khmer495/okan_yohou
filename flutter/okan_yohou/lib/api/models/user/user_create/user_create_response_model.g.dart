// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_create_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCreateResponseModel _$UserCreateResponseModelFromJson(
    Map<String, dynamic> json) {
  return UserCreateResponseModel(
    type: json['type'] as String?,
    attributes: json['attributes'] == null
        ? null
        : AttributesModel.fromJson(json['attributes'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserCreateResponseModelToJson(
        UserCreateResponseModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'attributes': instance.attributes,
    };
