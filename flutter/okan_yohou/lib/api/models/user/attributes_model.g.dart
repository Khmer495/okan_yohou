// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attributes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributesModel _$AttributesModelFromJson(Map<String, dynamic> json) {
  return AttributesModel(
    id: json['id'] as String?,
    lastLogin: json['last_login'],
    isSuperuser: json['is_superuser'] as bool?,
    username: json['username'] as String?,
    isStaff: json['is_staff'] as bool?,
    isActive: json['is_active'] as bool?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    photo: json['photo'],
    introduction: json['introduction'],
    lock: json['lock'] as int?,
    email: json['email'] as String?,
    gender: json['gender'] as int?,
    birthday: json['birthday'],
    residence: json['residence'] as int?,
    os: json['os'],
    jotsSum: json['jot_sum'] as int?,
    purchaseSum: json['purchase_sum'] as int?,
    reportedSum: json['reported_sum'] as int?,
    usingDeviceStatus: json['using_device_status'] as int?,
    finishedTutorial: json['finished_tutorial'] as int?,
    unpost: json['unpost'] as int?,
    paymentSatate: json['payment_state'] as int?,
    isDeleted: json['is_deleted'] as int?,
    firebaseUuid: json['firebase_uuid'] as String?,
    token: json['token'] as String?,
  );
}

Map<String, dynamic> _$AttributesModelToJson(AttributesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'last_login': instance.lastLogin,
      'is_superuser': instance.isSuperuser,
      'username': instance.username,
      'is_staff': instance.isStaff,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'photo': instance.photo,
      'introduction': instance.introduction,
      'lock': instance.lock,
      'email': instance.email,
      'gender': instance.gender,
      'birthday': instance.birthday,
      'residence': instance.residence,
      'os': instance.os,
      'jot_sum': instance.jotsSum,
      'purchase_sum': instance.purchaseSum,
      'reported_sum': instance.reportedSum,
      'using_device_status': instance.usingDeviceStatus,
      'finished_tutorial': instance.finishedTutorial,
      'unpost': instance.unpost,
      'payment_state': instance.paymentSatate,
      'is_deleted': instance.isDeleted,
      'firebase_uuid': instance.firebaseUuid,
      'token': instance.token,
    };
