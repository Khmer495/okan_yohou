import 'package:gamehub/api/models/user/check_user_exist/check_user_exist_response_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_user_exist_data_model.g.dart';

@JsonSerializable()
class CheckUserExistDataModel {
  CheckUserExistDataModel({
    this.data
  });

  factory CheckUserExistDataModel.fromJson(Map<String, dynamic> json) =>
      _$CheckUserExistDataModelFromJson(json);

  CheckUserExistResponseModel? data;


  @override
  Map<String, dynamic> toJson() => _$CheckUserExistDataModelToJson(this);
}