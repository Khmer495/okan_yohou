// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trigger_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TriggerModel _$TriggerModelFromJson(Map<String, dynamic> json) {
  return TriggerModel(
      wx : json['wx'] as int?,
      temp : json['temp']  as double?,
      arpress : json['arpress']  as int?,
      wndspd : json['wndspd']  as int?,
      rhum : json['rhum']  as int?,
      feeltmp : json['feeltmp']  as int?
  );
}

Map<String, dynamic> _$TriggerModelToJson(TriggerModel instance) =>
    <String, dynamic>{
      'wx': instance.wx,
      'temp': instance.temp,
      'arpress': instance.arpress,
      'wndspd': instance.wndspd,
      'rhum': instance.rhum,
      'feeltmp': instance.feeltmp
    };
