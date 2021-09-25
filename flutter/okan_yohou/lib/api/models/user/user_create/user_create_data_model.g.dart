// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_create_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCreateDataModel _$UserCreateDataModelFromJson(Map<String, dynamic> json) {
  return UserCreateDataModel(
    data: json['data'] == null
        ? null
        : UserCreateResponseModel.fromJson(
            json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserCreateDataModelToJson(
        UserCreateDataModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
