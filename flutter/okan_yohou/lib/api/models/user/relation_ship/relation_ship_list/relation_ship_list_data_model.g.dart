// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation_ship_list_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelationShipListDataModel _$RelationShipListDataModelFromJson(
    Map<String, dynamic> json) {
  return RelationShipListDataModel(
    data: json['data'] == null
        ? null
        : RelationShipListResponseModel.fromJson(
            json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RelationShipListDataModelToJson(
        RelationShipListDataModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
