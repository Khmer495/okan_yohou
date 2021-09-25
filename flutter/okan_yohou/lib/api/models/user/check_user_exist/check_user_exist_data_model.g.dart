// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_user_exist_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckUserExistDataModel _$CheckUserExistDataModelFromJson(
    Map<String, dynamic> json) {
  return CheckUserExistDataModel(
    data: json['data'] == null
        ? null
        : CheckUserExistResponseModel.fromJson(
            json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CheckUserExistDataModelToJson(
        CheckUserExistDataModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
