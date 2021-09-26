import 'package:json_annotation/json_annotation.dart';
import 'my_profile_response_model.dart';

part 'my_profile_data_model.g.dart';

@JsonSerializable()
class MyProfileDataModel {
  MyProfileDataModel({
    this.data,
  });

  factory MyProfileDataModel.fromJson(Map<String, dynamic> json) =>
      _$MyProfileDataModelFromJson(json);
  MyProfileResponseModel? data;

  @override
  Map<String, dynamic> toJson() => _$MyProfileDataModelToJson(this);
}
