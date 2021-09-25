import 'package:gamehub/api/models/common/api_model.dart';
import 'package:gamehub/api/models/common/jot_model.dart';
import 'package:gamehub/api/models/common/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_patch_response.g.dart';

@JsonSerializable()
class UserPatchResponseModel {
  UserPatchResponseModel(
      {required this.type, this.user});

  factory UserPatchResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserPatchResponseModelFromJson(json);

  String? type;
  UserModel? user;

  @override
  Map<String, dynamic> toJson() => _$UserPatchResponseModelToJson(this);
}
