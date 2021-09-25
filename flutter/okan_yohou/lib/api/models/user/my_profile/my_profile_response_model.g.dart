// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_profile_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyProfileResponseModel _$MyProfileResponseModelFromJson(
    Map<String, dynamic> json) {
  return MyProfileResponseModel(
    type: json['type'] as String?,
    user: json['user'] == null
        ? null
        : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    jots: (json['jots'] as List<dynamic>?)
        ?.map((e) => JotModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MyProfileResponseModelToJson(
        MyProfileResponseModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'user': instance.user,
      'jots': instance.jots,
    };
