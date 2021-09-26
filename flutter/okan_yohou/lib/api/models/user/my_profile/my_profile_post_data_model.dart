// todo 使ってなかったら削除

// import 'package:gamehub/api/models/common/jot_model.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'my_profile_piece_model.dart';
//
// part 'my_profile_post_data_model.g.dart';
//
// @JsonSerializable()
// class MyProfilePostDataModel {
//   MyProfilePostDataModel({
//     this.id,
//     this.jot,
//     this.piece,
//     this.isActive,
//     this.createdAt,
//     this.updateAt,
//     this.isDeleted,
//   });
//
//   factory MyProfilePostDataModel.fromJson(Map<String, dynamic> json) =>
//       _$MyProfilePostDataModelFromJson(json);
//   int? id;
//   JotModel? jot;
//   MyProfilePieceModel? piece;
//   @JsonKey(name: 'is_active')
//   int? isActive;
//   @JsonKey(name: 'created_at')
//   DateTime? createdAt;
//   @JsonKey(name: 'updated_at')
//   DateTime? updateAt;
//   int? isDeleted;
//
//   @override
//   Map<String, dynamic> toJson() => _$MyProfilePostDataModelToJson(this);
// }
