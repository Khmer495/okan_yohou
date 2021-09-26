import 'package:json_annotation/json_annotation.dart';

part 'trigger_model.g.dart';

@JsonSerializable()
class TriggerModel {
  TriggerModel({
    this.wx,
    this.temp,
    this.arpress,
    this.wndspd,
    this.rhum,
    this.feeltmp
  });

  factory TriggerModel.fromJson(Map<String, dynamic> json) =>
      _$TriggerModelFromJson(json);

  int? wx;
  double? temp;
  int? arpress;
  int? wndspd;
  int? rhum;
  int? feeltmp;

  @override
  Map<String, dynamic> toJson() => _$TriggerModelToJson(this);
}
