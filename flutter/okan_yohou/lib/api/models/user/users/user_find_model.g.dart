// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_find_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFindModel _$UserFindModelFromJson(Map<String, dynamic> json) {
  return UserFindModel(
    itemcount: json['ic'] as int?,
    page: json['page'] as int?,
    keyword: json['search'] as String?,
  );
}

Map<String, dynamic> _$UserFindModelToJson(UserFindModel instance) =>
    <String, dynamic>{
      'ic': instance.itemcount,
      'page': instance.page,
      'search': instance.keyword,
    };
