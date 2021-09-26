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
    wx : json['wx'] as int?,
    temp : json['temp']  as double?,
    arpress : json['arpress']  as int?,
    wndspd : json['wndspd']  as int?,
    rhum : json['rhum']  as int?,
    feeltmp : json['feeltmp']  as int?,
    lat : json['lat']  as double?,
    lon : json['lon']  as double?,
  );
}

Map<String, dynamic> _$AlertModelToJson(AlertModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'text': instance.text,
      'wx': instance.wx,
      'temp': instance.temp,
      'arpress': instance.arpress,
      'wndspd': instance.wndspd,
      'rhum': instance.rhum,
      'feeltmp': instance.feeltmp,
      'lat': instance.lat,
      'lon': instance.lon,
    };
