import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:okanyohou/components/text_button.dart';
import 'package:okanyohou/screen/alert_edit.dart';
import 'package:okanyohou/screen/view_model/top_view_model.dart';
import 'package:okanyohou/util/color.dart';
import 'package:provider/provider.dart';

class Top extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double sheight = MediaQuery
        .of(context)
        .size
        .height;
    return ChangeNotifierProvider<TopViewModel>(
        create: (_) => TopViewModel()..init(),
        child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              backgroundColor: ConstantsColors.mainColor,
                body: Consumer<TopViewModel>(
                    builder: (context, model, child) {
                      if (!model.initialized) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Container(
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
                            Text('天気や気圧の変化におかんが気づいて教えてくれます。　例えば晴れと思っていても「傘持って行き」とおかんに言われたら素直に持っていきましょう！',
                                style:  TextStyle(color:ConstantsColors.white)),
                            Container(
                              margin: EdgeInsets.only(top:30,bottom:10),
                              child: Text(
                                "登録おかん",
                                style: TextStyle(
                                  color: ConstantsColors.black,
                                  decoration: TextDecoration.underline,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 30),
                              height: 300,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  // physics:,
                                  reverse: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: 10,
                                  itemBuilder: (context, index){
                                    return alertItem('$index 雨が降った時を教えて！');
                                  }
                              ),
                            ),
                            OutlinedButton(
                              child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                                  child: Text('+ 追加する',style:TextStyle(fontSize: 19) ,)
                              ),
                              style: OutlinedButton.styleFrom(
                                primary: ConstantsColors.black,
                                backgroundColor: ConstantsColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                side: BorderSide(width: 3),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => AlertEdit(),
                                    ));
                              },
                            ),
                            SizedBox(height: 15,),
                            CommonTextButton(text: '- 削除する',
                              onPressed: (context) async{
                                model.getAlerts();
                                print('AAA');
                            },),
                          ],
                        ),
                      );
                    }
                )
            )
        )
    );
  }
  Widget alertItem(String text){
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/okan_icon.png'),
          Container(
            margin: EdgeInsets.only(left:5),
            decoration: BoxDecoration(
              color: ConstantsColors.white,
              border: Border.all(color: ConstantsColors.black,width: 3),
              borderRadius: BorderRadius.circular(6),
            ),
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
            child:Text('雨が降った時を教えて！',style: TextStyle(fontSize: 20),),
          )
        ],
      ),
    );
  }
}

