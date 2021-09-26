// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlertModel _$AlertModelFromJson(Map<String, dynamic> json) {
  return AlertModel(
    id : json['id']  as String?,
    title : json['title']  as String?,
    text : json['text']  as String?,
    location: json['location'] == null
        ? null
        : LocationModel.fromJson(
        json['location'] as Map<String, dynamic>),
    trigger: json['trigger'] == null
        ? null
        : TriggerModel.fromJson(
        json['trigger'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AlertModelToJson(AlertModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'text': instance.text,
      'location': instance.location,
      'trigger': instance.trigger,

    };
