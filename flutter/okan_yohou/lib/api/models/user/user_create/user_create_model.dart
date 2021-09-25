import 'package:json_annotation/json_annotation.dart';

part 'user_create_model.g.dart';

@JsonSerializable()
class UserCreateModel {
  UserCreateModel(
      {this.token,
      this.name,
      this.email,
      this.birthday,
      this.gender,
      this.residence,
      this.password,
      this.gamistory});

  factory UserCreateModel.fromJson(Map<String, dynamic> json) =>
      _$UserCreateModelFromJson(json);
  String? token;
  String? name;
  String? email;
  String? birthday;
  int? gender;
  int? residence;
  String? password;
  String? gamistory;

  @override
  Map<String, dynamic> toJson() => _$UserCreateModelToJson(this);
}
