// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation_ship_object_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelationShipObjectModel _$RelationShipObjectModelFromJson(
    Map<String, dynamic> json) {
  return RelationShipObjectModel(
    id: json['id'] as int?,
    fromUserId: json['from_user_id'] as String?,
    fromUserName: json['from_user_name'] as String?,
    fromPhoto: json['from_photo'] as String?,
    fromStateName: json['from_state_name'] as String?,
    fromStateDisplayName: json['from_state_display_name'] as String?,
    toUserId: json['to_user_id'] as String?,
    toUserName: json['to_user_name'] as String?,
    toStateName: json['to_state_name'] as String?,
    toPhoto: json['to_photo'] as String?,
    toStateDisplayName: json['to_state_display_name'] as String?,
    stateName: json['state_name'] as String?,
  );
}

Map<String, dynamic> _$RelationShipObjectModelToJson(
        RelationShipObjectModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'from_user_id': instance.fromUserId,
      'from_user_name': instance.fromUserName,
      'from_photo': instance.fromPhoto,
      'from_state_name': instance.fromStateName,
      'from_state_display_name': instance.fromStateDisplayName,
      'to_user_id': instance.toUserId,
      'to_user_name': instance.toUserName,
      'to_photo': instance.toPhoto,
      'to_state_name': instance.toStateName,
      'to_state_display_name': instance.toStateDisplayName,
      'state_name': instance.stateName,
    };
