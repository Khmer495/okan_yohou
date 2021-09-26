import 'package:flutter/material.dart';
import 'package:okanyohou/util/color.dart';

/// 汎用的な[TextButton]
//渡したいパラメータは自由に追加していただいて大丈夫です。
class CommonTextButton extends StatelessWidget {
  const CommonTextButton({
    required this.text,
    required this.onPressed,
  });
  final String text;
  final Function(BuildContext) onPressed;
  @override
  Widget build(BuildContext context) {
    return
      OutlinedButton(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
            child: Text(text,style:TextStyle(fontSize: 19) ,)
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
          onPressed;
        },
      );
  }
}
