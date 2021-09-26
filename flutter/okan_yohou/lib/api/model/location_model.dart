import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable()
class LocationModel {
  LocationModel({
    this.lat,
    this.lon,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  double? lat;
  double? lon;

  @override
  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
