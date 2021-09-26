// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation_ship_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelationShipListResponseModel _$RelationShipListResponseModelFromJson(
    Map<String, dynamic> json) {
  return RelationShipListResponseModel(
    type: json['type'] as String?,
    data: (json['data'] as List<dynamic>?)
        ?.map(
            (e) => RelationShipObjectModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RelationShipListResponseModelToJson(
        RelationShipListResponseModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
    };
