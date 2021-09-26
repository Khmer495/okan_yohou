import 'package:json_annotation/json_annotation.dart';

part 'user_patch_model.g.dart';

@JsonSerializable()
class UserPatchModel {
  UserPatchModel({
    this.photo,
    this.photoName,
    this.introduction,
    this.lock,
    this.residence,
    this.os,
    this.username,
    this.birthday,
    this.gender,
    this.password,
    this.fcmToken,
    this.email
  });

  factory UserPatchModel.fromJson(Map<String, dynamic> json) =>
      _$UserPatchModelFromJson(json);
  String? photo;
  String? photoName;
  String? introduction;
  int? lock; ///0で公開、1で鍵あり
  int? residence;
  int? os;
  String? username;
  String? birthday;
  int? gender;
  String? password;
  @JsonKey(name: 'fcm_token')
  String? fcmToken;
  String? email;

  @override
  Map<String, dynamic> toJson() => _$UserPatchModelToJson(this);
}
