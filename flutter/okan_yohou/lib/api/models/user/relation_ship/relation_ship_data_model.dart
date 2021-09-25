import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gamehub/api/models/objective_room/objective_room_create_response_data_model.dart';
import 'package:gamehub/api/models/user/relation_ship/relation_ship_response_model.dart';

part 'relation_ship_data_model.g.dart';

@JsonSerializable()
class RelationShipDataModel {
  RelationShipDataModel({
    this.data,
  });

  factory RelationShipDataModel.fromJson(Map<String, dynamic> json) =>
      _$RelationShipDataModelFromJson(json);

  RelationShipResponseModel? data;

  @override
  Map<String, dynamic> toJson() => _$RelationShipDataModelToJson(this);
}