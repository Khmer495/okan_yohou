import 'package:json_annotation/json_annotation.dart';
import 'package:okanyohou/api/model/location_model.dart';
import 'package:okanyohou/api/model/trigger_model.dart';

part 'alert_model.g.dart';

@JsonSerializable()
class AlertModel {
  AlertModel({
    this.id,
    this.title,
    this.location,
    this.trigger,
    this.text,
  });

  factory AlertModel.fromJson(Map<String, dynamic> json) =>
      _$AlertModelFromJson(json);

  String? id;
  String? title;
  LocationModel? location;
  TriggerModel? trigger;
  String? text;

  @override
  Map<String, dynamic> toJson() => _$AlertModelToJson(this);
}
