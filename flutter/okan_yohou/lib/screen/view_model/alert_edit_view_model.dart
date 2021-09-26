import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:okanyohou/api/api_repository.dart';
import 'package:okanyohou/api/api_response.dart';
import 'package:okanyohou/api/model/alert_model.dart';

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

    Future<void> postAlert()async{
      final model = AlertModel()
        ..text='AAA'
        ..title='BBB'
        ..lat=35.6769
        ..lon=139.75;

      await _apiRepository.postAlert(parameter: model.toJson())
          .then((response) async {
        if (response.apiStatus != ApiResponseType.ok) {
          notifyListeners();
        }
      }).catchError((Object e) {
        print('postAlert:$e');
        switch (e.runtimeType) {
          case DioError:
            notifyListeners();
            break;
          default:
            notifyListeners();
            throw e;
        }
      });
    }


}

