
import 'package:gamehub/api/models/common/common_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../attributes_model.dart';

part 'user_create_response_model.g.dart';

@JsonSerializable()
class UserCreateResponseModel {
  UserCreateResponseModel({required this.type, this.attributes});

  factory UserCreateResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserCreateResponseModelFromJson(json);

  String? type;
  AttributesModel? attributes;

  @override
  Map<String, dynamic> toJson() => _$UserCreateResponseModelToJson(this);
}
