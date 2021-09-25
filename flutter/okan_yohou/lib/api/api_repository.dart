import 'package:dio/dio.dart' hide Headers;
import 'package:gamehub/api/models/agora/get_token/agora_data_model.dart';
import 'package:gamehub/api/models/chat/objective_chat/objective_chat_data_model.dart';
import 'package:gamehub/api/models/individual_room/individual_room_create_model/individual_room_create_data_model.dart';
import 'package:gamehub/api/models/individual_room/individual_room_get_model/individual_room_data_model.dart';
import 'package:gamehub/api/models/objective_room/objective_room_leave_data_model.dart';
import 'package:gamehub/api/models/agora/vc_joined_room/vc_joined_data_model.dart';
import 'package:gamehub/api/models/start/check_joining_objective_room_data_model.dart';
import 'package:gamehub/api/models/user/check_user_exist/check_user_exist_data_model.dart';
import 'package:gamehub/api/models/user/relation_ship/relation_ship_data_model.dart';
import 'package:gamehub/api/models/user/relation_ship/relation_ship_list/relation_ship_list_data_model.dart';
import 'package:gamehub/manager/my_data_manager.dart';
import 'api_client.dart';
import 'api_endpoint.dart';
import 'api_response.dart';
import 'models/agora/join_call_model/join_call_data_model.dart';
import 'models/agora/matching/matching_data_model.dart';
import 'models/chat/objective_chat_post/objective_chat_post_data_model.dart';
import 'models/common/contact_model.dart';
import 'models/game/games/games_model.dart';
import 'models/game/my_game/my_game_data_model.dart';
import 'models/game/register_game/register_game_response_model.dart';
import 'models/objective_room/objective_room_create_data_model.dart';
import 'models/objective_room/objective_room_create_response_data_model.dart';
import 'models/post/jot_post/jot_post_response_model.dart';
import 'models/post/posts/post_data_model.dart';
import 'models/user/my_profile/my_profile_data_model.dart';
import 'models/user/relation_ship/relation_ship_response_model.dart';
import 'models/user/user_create/user_create_data_model.dart';
import 'models/user/user_patch/user_patch_response.dart';
import 'models/objective_room/objective_room_data_model.dart';
import 'models/objective_room/objective_room_response_model.dart';


class ApiRepository {
  ApiRepository._() {
    // リリースモードでは assert が走らないことを利用して環境を分けている
    // 参考: https://star-zero.medium.com/flutterでdebug実行を判定する-769d92fa682c
    assert(isDebug = true);

    final dio = new Dio();
    dio.options.connectTimeout = 60*1000;
    dio.options.receiveTimeout =  60*1000;
    dio.options.sendTimeout = 60*10000;

    if (isDebug) {
      dio.interceptors.add(
        LogInterceptor()
          ..requestBody = true
          ..responseBody = true,
      );
    }
    _client = ApiClient(dio);
  }

  /// リポジトリを使用する場合は ApiRepository.instance を呼ぶこと
  static ApiRepository instance = ApiRepository._();

  late ApiClient _client;
  bool isDebug = false;

  ///ユーザーの作成
  ///paramaterにはUserCreateModelを使用
  Future<ApiResponse> userCreate(
      {required Map<String, dynamic> parameter}) async {
    try {
      print("start user create");
      final response = await _client.userCreate(
          data: FormData.fromMap(parameter), api: API.userCreate);
      final responseData =
          UserCreateDataModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 201) {
        MyDataManager.instance.setUserId(responseData.data!.attributes!.id!);

        print(responseData.data);
        print(MyDataManager.instance.getUserId());

        return ApiResponse(
            apiStatus: ApiResponseType.created,
            result: responseData.data!.attributes);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      print("user create dio error");
      print(e);
      throw (e);
    } on Exception catch (_) {
      print("user create other error");
      print(_);
      rethrow;
    }
  }

  // ユーザーがすでに登録されているかを確認する
  Future<ApiResponse> checkUserExist(
      {required String firebaseUUID}) async {
    try {
      final response = await _client.checkUserExist(
          api: API.userExist, requiredIds: firebaseUUID);
      final responseData =
          CheckUserExistDataModel.fromJson(response.data as Map<String, dynamic>);

      if (response.statusCode == 200 && responseData.data!.userExist == "false") {
        print("user does not exist");
        return ApiResponse(
            apiStatus: ApiResponseType.yetCreated,
            result: null);
      } else if (response.statusCode == 200 && responseData.data!.userExist == "true"){
        print("user exists");
        MyDataManager.instance.setUserModel(responseData.data!.user);
        return ApiResponse(
            apiStatus: ApiResponseType.created,
            result: responseData.data!.user);
      } else {
        print("user not found");
        return ApiResponse(
            apiStatus: ApiResponseType.notFound,
            result: null);
      }
    } on DioError catch (e) {
      throw DioError(
          response: e.response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
    } on Exception catch (_) {
      print("user exist other error");
      print(_);
      rethrow;
    }
  }

  // ユーザーがobjectiveRoomに参加しているかを確認する
  Future<ApiResponse> checkJoiningObjectiveRoom() async {
    try {
      final response = await _client.post(api: API.checkJoiningObjectiveRoom);
      final responseData =
          CheckJoiningObjectiveRoomDataModel.fromJson(response.data as Map<String, dynamic>);

      if (response.statusCode == 200) {
        if (responseData.message != null){
          return ApiResponse(
            apiStatus: ApiResponseType.notFound,
            result: null);
        }else {
          return ApiResponse(
            apiStatus: ApiResponseType.ok,
            result: responseData.data);
        }
      } else {
        return ApiResponse(
            apiStatus: ApiResponseType.badRequest,
            result: null);
      }
    } on DioError catch (e) {
      throw DioError(
          response: e.response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
    } on Exception catch (_) {
      print("user exist other error");
      print(_);
      rethrow;
    }
  }

  ///マイデータの取得
  Future<ApiResponse> getMyProfile({required String userId}) async {
    try {
      final response =
          await _client.getWithIds(api: API.myProfile, requiredIds: userId);
      final responseData =
          MyProfileDataModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 200) {
        return ApiResponse(
            apiStatus: ApiResponseType.ok, result: responseData.data);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      throw (e);
    } on Exception catch (_) {
      rethrow;
    }
  }

  //ユーザー詳細の更新
  //paramaterにはUserPatchModelを使用
  Future<ApiResponse> patchUserDetail(
      {required Map<String, dynamic> parameter, required String userId}) async {
    try {
      final response = await _client.patch(
          data: FormData.fromMap(parameter),
          api: API.userDetail,
          requiredId: userId);

      ///返ってくるのはid, username, lock, introduction, jots_sum, os, purchanse_sum　のみ
      final responseData =
        UserPatchResponseModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 202) {
        return ApiResponse(
            apiStatus: ApiResponseType.patched,
            result: responseData);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      throw (e);
    } on Exception catch (_) {
      rethrow;
    }
  }

  ///キーワードを用いてのユーザ一覧取得（keywordが埋まっている→keywordにヒットしたひと全部）
  ///paramaterにはUserFindModelを使用, result = List<UserModel>
  // Future<ApiResponse> findUsersWithKeyWords(
  //     {required Map<String, dynamic> parameter, required String userId}) async {
  //   try {
  //     final response =
  //         await _client.get(parameter: parameter, api: API.userDetail);
  //     final responseData =
  //         UserDetailDataModel.fromJson(response.data as Map<String, dynamic>);
  //     if (response.statusCode == 200) {
  //       return ApiResponse(
  //           apiStatus: ApiResponseType.ok, result: responseData.data!.user);
  //     } else {
  //       throw DioError(
  //         response: response,
  //         type: DioErrorType.response,
  //         requestOptions: RequestOptions(path: ''),
  //       );
  //     }
  //   } on DioError catch (e) {
  //     throw (e);
  //   } on Exception catch (_) {
  //     rethrow;
  //   }
  // }

  //useridに該当するユーザー1人を取得(自分も他人も1人で1Dがわかる場合にはこちらを利用)
  //paramaterにはUserFindModelを使用, result = List<UserModel>
  // Future<ApiResponse> getUserDetail({required String userId}) async {
  //   try {
  //     final response =
  //         await _client.getWithIds(api: API.userDetail, requiredIds: userId);

  //     print("get response");
  //     final responseData =
  //         UserDetailDataModel.fromJson(response.data as Map<String, dynamic>);
  //     if (response.statusCode == 200) {
  //       return ApiResponse(
  //           apiStatus: ApiResponseType.ok, result: responseData.data!.user);
  //     } else {
  //       throw DioError(
  //         response: response,
  //         type: DioErrorType.response,
  //         requestOptions: RequestOptions(path: ''),
  //       );
  //     }
  //   } on DioError catch (e) {
  //     throw (e);
  //   } on Exception catch (_) {
  //     rethrow;
  //   }
  // }

  ///ゲーム全件取得
  Future<ApiResponse> getGameList() async {
    try {
      final response = await _client.get(
        api: API.games,
      );
      final responseData =
          GamesModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 200) {
        return ApiResponse(
            apiStatus: ApiResponseType.ok, result: responseData.data);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      throw (e);
    } on Exception catch (_) {
      rethrow;
    }
  }

  ///ゲーム情報の取得（検索用）
  ///paramaterにはGameFindModelを使用
  Future<ApiResponse> getGames(
      Map<String, dynamic> parameter, String? gameId) async {
    try {
      final response = await _client.getWithIds(
        api: API.games,
        parameter: parameter,
        requiredIds: gameId ?? "",
      );
      final responseData =
          GamesModel.fromJson(response.data as Map<String, dynamic>);
      if (response.data!.statusCode == 200) {
        return ApiResponse(apiStatus: ApiResponseType.ok, result: responseData);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      throw (e);
    } on Exception catch (_) {
      rethrow;
    }
  }

  ///ゲームの登録
  ///paramaterにはRegisterGameModelを使用
  Future<ApiResponse> registerGame(
      {required Map<String, dynamic> parameter, required String gameId}) async {
    try {
      final response = await _client.patchWithIds(
          api: API.gameRegistration,
          data: FormData.fromMap(parameter),
          requiredId: gameId);
      final responseData = RegisterGameResponseModel.fromJson(
          response.data as Map<String, dynamic>);
      if (response.statusCode == 202) {
        return ApiResponse(apiStatus: ApiResponseType.ok, result: responseData);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      throw (e);
    } on Exception catch (_) {
      rethrow;
    }
  }

  ///登録ゲームの更新
  ///paramaterにはRegisteredGamePatchModelを使用
  Future<ApiResponse> patchRegisteredGame(
      {required Map<String, dynamic> parameter, required String gameId}) async {
    try {
      final response = await _client.patchWithIds(
          api: API.gameRegistration,
          data: FormData.fromMap(parameter),
          requiredId: gameId);
      final responseData = RegisterGameResponseModel.fromJson(
          response.data as Map<String, dynamic>);
      if (response.statusCode == 202) {
        return ApiResponse(apiStatus: ApiResponseType.ok, result: responseData);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      throw (e);
    } on Exception catch (_) {
      rethrow;
    }
  }

  ///登録ゲーム情報の取得
  Future<ApiResponse> getMyGames() async {
    try {
      final response = await _client.get(api: API.myGames);
      final responseData =
          MyGameDataModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 200) {
        return ApiResponse(
            apiStatus: ApiResponseType.ok, result: responseData.data);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      throw (e);
    } on Exception catch (_) {
      rethrow;
    }
  }

  ///つぶやき、投稿一覧の取得
  Future<ApiResponse> getJots() async {
    try {
      final response =
          await _client.get(api: API.jot);
      final responseData =
          PostDataModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 200) {
        return ApiResponse(
            apiStatus: ApiResponseType.ok, result: responseData.data);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      throw (e);
    } on Exception catch (_) {
      rethrow;
    }
  }
  
  ///つぶやきpost
  ///paramaterにはjotPostModelを使用
  Future<ApiResponse> postJots(
      {required Map<String, dynamic> parameter}) async {
    try {
      final response =
          await _client.post(api: API.jot, data: FormData.fromMap(parameter));
      final responseData =
          JotPostResponseModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 201) {
        return ApiResponse(
            apiStatus: ApiResponseType.ok, result: responseData.jot);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      throw (e);
    } on Exception catch (_) {
      rethrow;
    }
  }

  ///お問い合わせpost
  ///paramaterにはContactModelを使用
  Future<ApiResponse> postContact(
      {required Map<String, dynamic> parameter}) async {
    try {
      final response = await _client.post(
          api: API.contact, data: FormData.fromMap(parameter));
      final responseData =
          ContactModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 201) {
        return ApiResponse(apiStatus: ApiResponseType.ok, result: responseData);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      throw (e);
    } on Exception catch (_) {
      rethrow;
    }
  }

  /// agora
  Future<ApiResponse> getAgoraTokenWithObjectiveRoom(
      {required Map<String, dynamic> parameter, required String objectiveRoomId}) async {
    try {
      final response = await _client.postWithIds(
        api: API.agoraTokenForObjectiveRoom, 
        requiredIds: objectiveRoomId, 
        data: FormData.fromMap(parameter));
      final responseData =
        AgoraDataModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 201) {
        return ApiResponse(
            apiStatus: ApiResponseType.created,
            result: responseData.data);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      print(e);
      throw (e);
    } on Exception catch (_) {
      print(_);
      rethrow;
    }
  }

  Future<ApiResponse> getAgoraTokenWithIndividualRoom(
      {required Map<String, dynamic> parameter, required String objectiveRoomId}) async {
    try {
      final response = await _client.postWithIds(
        api: API.agoraTokenForIndividualRoom, 
        requiredIds: objectiveRoomId, 
        data: FormData.fromMap(parameter));
      final responseData =
        AgoraDataModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 201) {
        return ApiResponse(
            apiStatus: ApiResponseType.created,
            result: responseData.data);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      print(e);
      throw (e);
    } on Exception catch (_) {
      print(_);
      rethrow;
    }
  }

  Future<ApiResponse> joinObjectiveVoiceCall(
      {required String objectiveRoomId}) async {
    try {
      final response = await _client.postWithIds(
        api: API.joinCallObjectiveRoom, 
        requiredIds: objectiveRoomId, 
      );
      final responseData =
        JoinCallDataModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 201) {
        return ApiResponse(
            apiStatus: ApiResponseType.created,
            result: responseData.data);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      print(e);
      throw (e);
    } on Exception catch (_) {
      print(_);
      rethrow;
    }
  }

  Future<ApiResponse> joinIndividualVoiceCall(
      {required String individualRoomId}) async {
    try {
      final response = await _client.postWithIds(
        api: API.joinCallIndividualRoom, 
        requiredIds: individualRoomId, 
      );
      final responseData =
        JoinCallDataModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 201) {
        return ApiResponse(
            apiStatus: ApiResponseType.created,
            result: responseData.data);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      print(e);
      throw (e);
    } on Exception catch (_) {
      print(_);
      rethrow;
    }
  }


  ///paramaterにはobjectRoomModelを使用
  Future<ApiResponse> createObjectiveRoom(String gameId, Map<String, dynamic> parameter) async {
    try {
      final response = await _client.postWithIds(
        requiredIds: gameId,
        api: API.objectiveRoom,
        data: FormData.fromMap(parameter)
      );
      final responseData =
        ObjectiveRoomCreateDataModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return ApiResponse(apiStatus: ApiResponseType.ok, result: responseData.data);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      throw (e);
    } on Exception catch (_) {
      rethrow;
    }
  }

  ///オブジェクトルーム
  Future<ApiResponse> getObjectiveRoom() async {
    try {
      final response = await _client.get(
        api: API.objectiveRoom,
      );
      final responseData =
        ObjectiveRoomDataModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 200) {
        return ApiResponse(apiStatus: ApiResponseType.ok, result: responseData.data);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      throw (e);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse> getObjectiveRoomWithGameId(String gameId) async {
    try {
      final response = await _client.getWithIds(
        requiredIds: gameId,
        api: API.objectiveRoom,
      );
      final responseData =
        ObjectiveRoomDataModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 200) {
        return ApiResponse(apiStatus: ApiResponseType.ok, result: responseData.data);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      throw (e);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse> leaveObjectiveRoomWithGameId(String objectiveRoomId) async {
    try {
      final response = await _client.patchWithIds(
        requiredId: objectiveRoomId,
        api: API.leaveObjectiveRoom, 
        data: null,
      );
      final responseData =
      ObjectiveRoomLeaveDataModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 202) {
        return ApiResponse(apiStatus: ApiResponseType.ok, result: responseData);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      throw (e);
    } on Exception catch (_) {
      rethrow;
    }
  }

  /// agoramatching
  Future<ApiResponse> agoraMatching(
      {required String gameId, required Map<String, dynamic> parameter}) async {
    try {
      final response = await _client.postWithIds(
        data: FormData.fromMap(parameter),
        api: API.matching,
        requiredIds: gameId);
      final responseData =
      MatchingDataModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 200) {
        return ApiResponse(
            apiStatus: ApiResponseType.created,
            result: responseData.data);      
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      print(e);
      throw (e);
    } on Exception catch (_) {
      print(_);
      rethrow;
    }
  }

  /// オブジェクトルームの参加者取得
  Future<ApiResponse> getRoomDetail(String objectiveRoomId) async {
    try {
      final response = await _client.getWithIds(
        requiredIds: objectiveRoomId,
        api: API.myRoom,
      );
      print(response.data);
      final responseData =
        VcJoinedDataModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 200) {
        return ApiResponse(apiStatus: ApiResponseType.ok, result: responseData.data);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      throw (e);
    } on Exception catch (_) {
      rethrow;
    }
  }

  /// 友達一覧取得
  Future<ApiResponse> getIndividualRoom() async {
    try {
      final response = await _client.get(
        api: API.individualRoom,
      );
      print(response.data);
      final responseData =
        IndividualRoomDataModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 200) {
        return ApiResponse(apiStatus: ApiResponseType.ok, result: responseData.data);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      throw (e);
    } on Exception catch (_) {
      rethrow;
    }
  }

  /// 友達登録
  Future<ApiResponse> createIndividualRoom(String userId) async {
    try {
      final response =
      await _client.postWithIds(api: API.individualRoom,requiredIds: userId );
      final responseData =
        IndividualCreateRoomDataModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 200) {
        return ApiResponse(
            apiStatus: ApiResponseType.created,
            result: responseData.data);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      print(e);
      throw (e);
    } on Exception catch (_) {
      print(_);
      rethrow;
    }
  }

  /// オープンチャットの投稿
  /// objectiveChatPostModelを使用
  Future<ApiResponse> postObjectiveChat(String objectiveRoomId, Map<String, dynamic> parameter) async {
    try {
      final response = await _client.postWithIds(
        api: API.objectiveRoomChat,
        requiredIds: objectiveRoomId,
        data: FormData.fromMap(parameter));
      final responseData =
        ObjectiveChatPostDataModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 201) {
        return ApiResponse(
            apiStatus: ApiResponseType.created,
            result: responseData.data);
      }else if(response.statusCode == 200){
        return ApiResponse(
            apiStatus: ApiResponseType.ok,
            result: responseData.data);
      }
      else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      print(e);
      throw (e);
    } on Exception catch (_) {
      print(_);
      rethrow;
    }
  }

  ///オープンチャットの取得
  ///ObjectiveChatModelを使用
  Future<ApiResponse> getObjectiveChat(String objectiveRoomId, Map<String, dynamic> parameter) async {
    try {
      final response = await _client.getWithIds(
        api: API.objectiveRoomChat,
        requiredIds: objectiveRoomId,
        parameter: parameter
        );
      final responseData =
        ObjectiveChatDataModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 200) {
        return ApiResponse(
            apiStatus: ApiResponseType.ok,
            result: responseData.data);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      print(e);
      throw (e);
    } on Exception catch (_) {
      print(_);
      rethrow;
    }
  }


  ///個人チャットの取得
  ///を使用
  Future<ApiResponse> getIndividualChat(String individualRoomId, Map<String, dynamic>? parameter) async {
    try {
      final response = await _client.getWithIds(
          api: API.individualChat,
          requiredIds: individualRoomId,
          parameter: parameter
      );
      final responseData =
      ObjectiveChatDataModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 200) {
        return ApiResponse(
            apiStatus: ApiResponseType.ok,
            result: responseData.data);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      print(e);
      throw (e);
    } on Exception catch (_) {
      print(_);
      rethrow;
    }
  }

  /// 個人の投稿
  /// objectiveChatPostModelを使用
  Future<ApiResponse> postIndividualChat(String individualRoomId, Map<String, dynamic> parameter) async {
    try {
      final response = await _client.postWithIds(
          api: API.individualChat,
          requiredIds: individualRoomId,
          data: FormData.fromMap(parameter));
      // final responseData =
      //   ObjectiveChatPostDataModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 200) {
        return ApiResponse(
            apiStatus: ApiResponseType.created,
            result: response.data);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      print(e);
      throw (e);
    } on Exception catch (_) {
      print(_);
      rethrow;
    }
  }


  /// roomの参加　基本オブジェクティブルームかな？
  ///
  Future<ApiResponse> joinRoom(String userId, Map<String, dynamic> parameter) async {
    try {
      final response = await _client.postWithIds(
          api: API.roomJoin,
          requiredIds: userId,
          data: FormData.fromMap(parameter));
      // final responseData =
      //   ObjectiveChatPostDataModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 201) {
        return ApiResponse(
            apiStatus: ApiResponseType.created,
            result: response.data);
      }
      else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      print(e);
      throw (e);
    } on Exception catch (_) {
      print(_);
      rethrow;
    }
  }


  /// 他ユーザーとの関係性全取得
  Future<ApiResponse> getRelationShipList() async {
    try {
      final response =
      await _client.get(api: API.relationShips);
      final responseData =
        RelationShipListDataModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 200) {
        return ApiResponse(
            apiStatus: ApiResponseType.ok,
            result: responseData.data);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      print(e);
      throw (e);
    } on Exception catch (_) {
      print(_);
      rethrow;
    }
  }

  /// 一人のユーザーとの関係性取得
  Future<ApiResponse> getRelationShipValue(String userId) async {
    try {
      final response =
      await _client.getWithIds(api: API.relationShips,requiredIds:userId );
      final responseData =
        RelationShipDataModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 200) {
        return ApiResponse(
            apiStatus: ApiResponseType.created,
            result: responseData.data);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      print(e);
      throw (e);
    } on Exception catch (_) {
      print(_);
      rethrow;
    }
  }

  /// 友達申請
  Future<ApiResponse> friendRequest(String userId,Map<String, dynamic> parameter) async {
    try {
      final response =
      await _client.postWithIds(api: API.relationShips,requiredIds:userId,
          data: FormData.fromMap(parameter));
      final responseData =
        RelationShipDataModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 200) {
        return ApiResponse(
            apiStatus: ApiResponseType.created,
            result: responseData.data);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      print(e);
      throw (e);
    } on Exception catch (_) {
      print(_);
      rethrow;
    }
  }

  /// 友達登録承認
  /// parameterは RelationShipObjectModel
  Future<ApiResponse> relationShipPatch(String userId,Map<String, dynamic> parameter) async {
    try {

      final response =
      await _client.patchWithIds(
          api: API.relationShips,requiredId:userId ,
          data: FormData.fromMap(parameter));
      final responseData =
        RelationShipResponseModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 202) {
        return ApiResponse(
            apiStatus: ApiResponseType.ok,
            result: responseData);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      print(e);
      throw (e);
    } on Exception catch (_) {
      print(_);
      rethrow;
    }
  }

  /// ユーザー削除
  Future<ApiResponse> deleteUser(String userId) async {
    try {

      final response =
      await _client.deleteWithIds(
          api: API.userDetail,
          requiredId: userId
      );
      if (response.statusCode == 200) {
        return ApiResponse(
            apiStatus: ApiResponseType.ok,
            result: response.data);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      print(e);
      throw (e);
    } on Exception catch (_) {
      print(_);
      rethrow;
    }
  }

}
