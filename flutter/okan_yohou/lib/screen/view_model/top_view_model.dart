import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:okanyohou/api/api_repository.dart';

class TopViewModel extends ChangeNotifier {
  bool initialized=false;
  final _apiRepository = ApiRepository.instance;

  Future<void> init() async {
    initialized=true;
    notifyListeners();
  }
}
