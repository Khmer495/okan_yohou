import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:okanyohou/api/api_repository.dart';

class AlertEditViewModel extends ChangeNotifier {
  bool initialized=false;
  final _apiRepository = ApiRepository.instance;
  bool simpleAccordion = false;
  bool detailAccordion = false;
  TextEditingController titleController= TextEditingController();
  TextEditingController addressController= TextEditingController();
  TextEditingController contentController= TextEditingController();
  TextEditingController temperatureController= TextEditingController();

  Future<void> init() async {
      initialized=true;
      notifyListeners();
    }

    void changeSimpleAccordion(){
      simpleAccordion=!simpleAccordion;
      notifyListeners();
    }

    void changeDetailAccordion(){
      detailAccordion=!detailAccordion;
      notifyListeners();
    }


}

