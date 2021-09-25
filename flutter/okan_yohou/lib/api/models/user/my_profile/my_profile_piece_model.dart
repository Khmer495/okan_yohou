// todo 使ってなかったら削除

// import 'package:gamehub/api/models/common/api_model.dart';
// import 'package:gamehub/api/models/common/common_model.dart';
// import 'package:gamehub/api/models/common/evaluation_model.dart';
// import 'package:gamehub/api/models/common/game_model.dart';
// import 'package:gamehub/api/models/common/user_model.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'my_profile_piece_model.g.dart';
//
// @JsonSerializable()
// class MyProfilePieceModel extends ApiModel {
//   MyProfilePieceModel({
//     this.id,
//     this.relatedGame,
//     this.evaluations,
//     this.title,
//     this.content,
//     this.createdAt,
//     this.updateAt,
//     this.views,
//     this.isActive,
//     this.isDeleted,
//     this.user,
//     this.favorite,
//   });
//
//   factory MyProfilePieceModel.fromJson(Map<String, dynamic> json) =>
//       _$MyProfilePieceModelFromJson(json);
//   String? id;
//   GameModel? relatedGame;
//   List<EvaluationModel>? evaluations;
//   String? title;
//   String? content;
//   @JsonKey(name: 'created_at')
//   String? createdAt;
//   @JsonKey(name: 'updated_at')
//   String? updateAt;
//   int? views;
//   @JsonKey(name: 'is_active')
//   int? isActive;
//   @JsonKey(name: 'is_deleted')
//   int? isDeleted;
//   String? user;
//   List<UserModel>? favorite;
//
//   @override
//   Map<String, dynamic> toJson() => _$MyProfilePieceModelToJson(this);
// }
