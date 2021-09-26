import 'package:gamehub/api/models/common/common_model.dart';
import 'package:gamehub/api/models/common/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_list_model.g.dart';

@JsonSerializable()
class UserListModel {
  UserListModel({required this.users});

  factory UserListModel.fromJson(Map<String, dynamic> json) =>
      _$UserListModelFromJson(json);

  List<UserModel> users;

  @override
  Map<String, dynamic> toJson() => _$UserListModelToJson(this);
}
