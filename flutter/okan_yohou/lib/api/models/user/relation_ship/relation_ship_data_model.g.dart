// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation_ship_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelationShipDataModel _$RelationShipDataModelFromJson(
    Map<String, dynamic> json) {
  return RelationShipDataModel(
    data: json['data'] == null
        ? null
        : RelationShipResponseModel.fromJson(
            json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RelationShipDataModelToJson(
        RelationShipDataModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
