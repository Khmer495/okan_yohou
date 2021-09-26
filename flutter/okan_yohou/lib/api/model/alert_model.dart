import 'package:json_annotation/json_annotation.dart';

part 'alert_model.g.dart';

@JsonSerializable()
class AlertModel {
  AlertModel({
    this.id,
    this.title,
    this.lat,
    this.lon,
    this.wx,
    this.temp,
    this.arpress,
    this.wndspd,
    this.rhum,
    this.feeltmp,
    this.text,
  });

  factory AlertModel.fromJson(Map<String, dynamic> json) =>
      _$AlertModelFromJson(json);

  String? id;
  String? title;
  double? lat;
  double? lon;
  int? wx;
  double? temp;
  int? arpress;
  int? wndspd;
  int? rhum;
  int? feeltmp;
  String? text;

  @override
  Map<String, dynamic> toJson() => _$AlertModelToJson(this);
}
