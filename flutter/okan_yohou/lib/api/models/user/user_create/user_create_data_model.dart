
import 'package:gamehub/api/models/user/user_create/user_create_response_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_create_data_model.g.dart';

@JsonSerializable()
class UserCreateDataModel {
  UserCreateDataModel({
    this.data,
  });

  factory UserCreateDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserCreateDataModelFromJson(json);
  UserCreateResponseModel? data;

  @override
  Map<String, dynamic> toJson() => _$UserCreateDataModelToJson(this);
}
