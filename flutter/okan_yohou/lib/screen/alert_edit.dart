import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:okanyohou/components/radio.dart';
import 'package:okanyohou/components/text_button.dart';
import 'package:okanyohou/screen/view_model/alert_edit_view_model.dart';
import 'package:okanyohou/util/color.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';

class AlertEdit extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    String _type = '';
    return ChangeNotifierProvider<AlertEditViewModel>(
        create: (_) => AlertEditViewModel()..init(),
        child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
                backgroundColor: ConstantsColors.mainColor,
                body: Consumer<AlertEditViewModel>(
                    builder: (context, model, child) {
                      if (!model.initialized) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return SingleChildScrollView(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 40,horizontal: 30),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(child: Image.asset('assets/images/okan_logo.png'),
                                margin:EdgeInsets.only(bottom:30),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon:  SvgPicture.asset(
                                      model.simpleAccordion
                                        ?'assets/images/close.svg'
                                        :'assets/images/open.svg',
                                      color: ConstantsColors.black,
                                    ),
                                    tooltip: 'Increase volume by 10',
                                    onPressed: () {
                                      model.changeSimpleAccordion();
                                    },
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('かんたん登録する',
                                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                      Text('項目をチェックすれば、おすすめ設定で\nかんたんに登録できます！'),
                                    ],
                                  )
                                ],
                              ),
                              model.simpleAccordion
                                  ?alertSimple(model)
                                  :Container(),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon:  SvgPicture.asset(
                                        model.detailAccordion
                                            ?'assets/images/close.svg'
                                            :'assets/images/open.svg',
                                        color: ConstantsColors.black,
                                      ),
                                      tooltip: 'Increase volume by 10',
                                      onPressed: () {
                                        model.changeDetailAccordion();
                                      },
                                    ),
                                    Text('詳細を登録する',
                                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),
                                    model.detailAccordion
                                        ?alertDetail(model)
                                        :Container(),
                            ],
                          ),
                        ),
                      );
                    }
                )
            )
        )
    );
  }

  Widget alertSimple(AlertEditViewModel model){
    return Column(
      children: [
        EasyAlertRadio(),
        CommonTextButton(
          text: '登録する',
          onPressed: (context) async{
            print('AAA');
          },
        ),
      ],
    );
  }

  Widget alertDetail(AlertEditViewModel model){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleText('タイトル'),
          inputField(model.titleController,'雨が降った時を教えて'),
          titleText('場所'),
          PlaceAlertRadio(),
          titleText('気温'),
          inputField(model.temperatureController,'22℃'),
          titleText('湿度'),
          HumidityAlertRadio(),
          titleText('風速'),
          WindAlertRadio(),
          titleText('気圧'),
          PressAlertRadio(),
          titleText('体感温度'),
          FeelAlertRadio(),
          titleText('通知文の編集'),
          inputField(model.contentController, 'おはよう！今日昼から雨降るから傘忘れんと持っていきや'),
          Center(
            child: CommonTextButton(
              text: '登録する',
              onPressed: (context) async{
                print('AAA');
              },),
          )
        ],
      ),
    );
  }

  Widget inputField(TextEditingController controller,String hintText){
    return Container(
      margin: EdgeInsets.only(bottom: 10,top: 20),
      child: TextField(
          controller: controller,
          keyboardType: TextInputType.text,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardAppearance: Brightness.light,
          maxLines: 1,
          style:
          TextStyle(fontSize: 16.0, color: Colors.black), //入力文字のサイズと色
          decoration: InputDecoration(
            filled: true,
            fillColor: ConstantsColors.gray2,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 11.0,
            ),
            contentPadding: EdgeInsets.all(10),
            enabledBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: ConstantsColors.black,width: 3), //　未選択時の下線の色
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ConstantsColors.black,width: 3),
              borderRadius: BorderRadius.circular(8),
            ),

          ),
          onChanged: (String value) {
            print(value);
            // editingController.text = value;
          }),
    );
  }

  Widget titleText(String title){
    return  Container(
      margin: EdgeInsets.only(top: 20),
      child: Text(title,
        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
      ),
    );
  }

}

