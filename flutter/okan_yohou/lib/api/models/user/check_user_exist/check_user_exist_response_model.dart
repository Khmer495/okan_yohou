import 'package:gamehub/api/models/common/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_user_exist_response_model.g.dart';

@JsonSerializable()
class CheckUserExistResponseModel {
  CheckUserExistResponseModel({
    this.type,
    this.userExist,
    this.user
  });

  factory CheckUserExistResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CheckUserExistResponseModelFromJson(json);

  String? type;
  @JsonKey(name: 'user_exist')
  String? userExist;
  UserModel? user;


  @override
  Map<String, dynamic> toJson() => _$CheckUserExistResponseModelToJson(this);
}