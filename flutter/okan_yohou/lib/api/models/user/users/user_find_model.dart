import 'package:json_annotation/json_annotation.dart';

part 'user_find_model.g.dart';

@JsonSerializable()
class UserFindModel {
  UserFindModel({
    this.itemcount,
    this.page,
    this.keyword,
  });

  factory UserFindModel.fromJson(Map<String, dynamic> json) =>
      _$UserFindModelFromJson(json);
  @JsonKey(name: 'ic')
  int? itemcount;
  int? page;
  @JsonKey(name: 'search')
  String? keyword;

  @override
  Map<String, dynamic> toJson() => _$UserFindModelToJson(this);
}
