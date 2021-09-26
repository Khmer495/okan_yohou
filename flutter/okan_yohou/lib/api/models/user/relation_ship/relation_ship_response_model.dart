import 'package:gamehub/api/models/user/relation_ship/relation_ship_object_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'relation_ship_response_model.g.dart';

@JsonSerializable()
class RelationShipResponseModel {
  RelationShipResponseModel({
    this.type,
    this.data
  });

  factory RelationShipResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RelationShipResponseModelFromJson(json);

  String? type;
  RelationShipObjectModel? data;

  @override
  Map<String, dynamic> toJson() => _$RelationShipResponseModelToJson(this);
}
