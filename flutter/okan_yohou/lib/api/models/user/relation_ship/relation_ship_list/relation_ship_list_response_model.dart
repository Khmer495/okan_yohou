import 'package:gamehub/api/models/user/relation_ship/relation_ship_object_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'relation_ship_list_response_model.g.dart';

@JsonSerializable()
class RelationShipListResponseModel {
  RelationShipListResponseModel({
    this.type,
    this.data
  });

  factory RelationShipListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RelationShipListResponseModelFromJson(json);

  String? type;
  List<RelationShipObjectModel>? data;

  @override
  Map<String, dynamic> toJson() => _$RelationShipListResponseModelToJson(this);
}
