import 'package:gamehub/api/models/user/relation_ship/relation_ship_list/relation_ship_list_response_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'relation_ship_list_data_model.g.dart';

@JsonSerializable()
class RelationShipListDataModel {
  RelationShipListDataModel({
    this.data,
  });

  factory RelationShipListDataModel.fromJson(Map<String, dynamic> json) =>
      _$RelationShipListDataModelFromJson(json);

  RelationShipListResponseModel? data;

  @override
  Map<String, dynamic> toJson() => _$RelationShipListDataModelToJson(this);
}