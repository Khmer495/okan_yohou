import 'package:json_annotation/json_annotation.dart';

part 'attributes_model.g.dart';

@JsonSerializable()
class AttributesModel {
  AttributesModel({
    this.id,
    this.lastLogin,
    this.isSuperuser,
    this.username,
    this.isStaff,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.photo,
    this.introduction,
    this.lock,
    this.email,
    this.gender,
    this.birthday,
    this.residence,
    this.os,
    this.jotsSum,
    this.purchaseSum,
    this.reportedSum,
    this.usingDeviceStatus,
    this.finishedTutorial,
    this.unpost,
    this.paymentSatate,
    this.isDeleted,
    this.firebaseUuid,
    this.token,
  });

  factory AttributesModel.fromJson(Map<String, dynamic> json) =>
      _$AttributesModelFromJson(json);
  String? id;
  @JsonKey(name: 'last_login')
  dynamic? lastLogin;
  @JsonKey(name: 'is_superuser')
  bool? isSuperuser;
  String? username;
  @JsonKey(name: 'is_staff')
  bool? isStaff;
  @JsonKey(name: 'is_active')
  bool? isActive;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  dynamic? photo;
  dynamic? introduction;
  int? lock;
  String? email;
  int? gender;
  dynamic? birthday;
  int? residence;
  dynamic? os;
  @JsonKey(name: 'jot_sum')
  int? jotsSum;
  @JsonKey(name: 'purchase_sum')
  int? purchaseSum;
  @JsonKey(name: 'reported_sum')
  int? reportedSum;
  @JsonKey(name: 'using_device_status')
  int? usingDeviceStatus;
  @JsonKey(name: 'finished_tutorial')
  int? finishedTutorial;
  int? unpost;
  @JsonKey(name: 'payment_state')
  int? paymentSatate;
  @JsonKey(name: 'is_deleted')
  int? isDeleted;
  @JsonKey(name: 'firebase_uuid')
  String? firebaseUuid;
  String? token;

  @override
  Map<String, dynamic> toJson() => _$AttributesModelToJson(this);
}
