import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:okanyohou/api/api_client.dart';
import 'package:okanyohou/api/api_repository.dart';
import 'package:okanyohou/api/api_response.dart';
import 'package:okanyohou/api/model/alert_model.dart';

class TopViewModel extends ChangeNotifier {
  bool initialized=false;
  late ApiClient _client;
  // late List<dynamic> alertModel;
  final _apiRepository = ApiRepository.instance;

  Future<void> init() async {
    initialized=true;
    notifyListeners();
    // await _apiRepository.getAlerts().then((response) async {
    //   alertModel=response.result;
    //   notifyListeners();
    // }).catchError((Object e) {
    //   print('alertModel:$e');
    //   switch (e.runtimeType) {
    //     case DioError:
    //       throw (e as DioError);
    //     default:
    //       throw e;
    //   }
    // });
  }
}
