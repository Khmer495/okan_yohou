import 'package:json_annotation/json_annotation.dart';

part 'check_user_exist_model.g.dart';

@JsonSerializable()
class CheckUserExistModel {
  CheckUserExistModel({
    this.firebaseUUID
  });

  factory CheckUserExistModel.fromJson(Map<String, dynamic> json) =>
      _$CheckUserExistModelFromJson(json);

  @JsonKey(name: 'firebase_uuid')
  String? firebaseUUID;


  @override
  Map<String, dynamic> toJson() => _$CheckUserExistModelToJson(this);
}
