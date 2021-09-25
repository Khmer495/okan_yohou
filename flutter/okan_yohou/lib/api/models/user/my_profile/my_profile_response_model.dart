import 'package:gamehub/api/models/common/common_model.dart';
import 'package:gamehub/api/models/common/jot_model.dart';
import 'package:gamehub/api/models/common/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'my_profile_post_data_model.dart';

part 'my_profile_response_model.g.dart';

@JsonSerializable()
class MyProfileResponseModel {
  MyProfileResponseModel(
      {required this.type, this.user, this.jots, });

  factory MyProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MyProfileResponseModelFromJson(json);

  String? type;
  UserModel? user;
  List<JotModel>? jots;

  @override
  Map<String, dynamic> toJson() => _$MyProfileResponseModelToJson(this);
}
