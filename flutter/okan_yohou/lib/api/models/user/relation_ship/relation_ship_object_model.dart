import 'package:json_annotation/json_annotation.dart';

part 'relation_ship_object_model.g.dart';

@JsonSerializable()
class RelationShipObjectModel {
  RelationShipObjectModel({
    this.id,
    this.fromUserId,
    this.fromUserName,
    this.fromPhoto,
    this.fromStateName,
    this.fromStateDisplayName,
    this.toUserId,
    this.toUserName,
    this.toStateName,
    this.toPhoto,
    this.toStateDisplayName,
    this.stateName,
  });

  factory RelationShipObjectModel.fromJson(Map<String, dynamic> json) =>
      _$RelationShipObjectModelFromJson(json);

  int? id;
  @JsonKey(name: 'from_user_id')
  String? fromUserId;
  @JsonKey(name: 'from_user_name')
  String? fromUserName;
  @JsonKey(name: 'from_photo')
  String? fromPhoto;
  @JsonKey(name: 'from_state_name')
  String? fromStateName;
  @JsonKey(name: 'from_state_display_name')
  String? fromStateDisplayName;
  @JsonKey(name: 'to_user_id')
  String? toUserId;
  @JsonKey(name: 'to_user_name')
  String? toUserName;
  @JsonKey(name: 'to_photo')
  String? toPhoto;
  @JsonKey(name: 'to_state_name')
  String? toStateName;
  @JsonKey(name: 'to_state_display_name')
  String? toStateDisplayName;

  @JsonKey(name: 'state_name')
  String? stateName;

  @override
  Map<String, dynamic> toJson() => _$RelationShipObjectModelToJson(this);
}
