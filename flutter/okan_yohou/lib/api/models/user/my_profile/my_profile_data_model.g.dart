// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_profile_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyProfileDataModel _$MyProfileDataModelFromJson(Map<String, dynamic> json) {
  return MyProfileDataModel(
    data: json['data'] == null
        ? null
        : MyProfileResponseModel.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MyProfileDataModelToJson(MyProfileDataModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
