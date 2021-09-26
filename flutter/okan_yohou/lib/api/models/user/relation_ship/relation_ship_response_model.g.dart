// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation_ship_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelationShipResponseModel _$RelationShipResponseModelFromJson(
    Map<String, dynamic> json) {
  return RelationShipResponseModel(
    type: json['type'] as String?,
    data: json['data'] == null
        ? null
        : RelationShipObjectModel.fromJson(
            json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RelationShipResponseModelToJson(
        RelationShipResponseModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
    };
