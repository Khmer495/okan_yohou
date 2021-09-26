import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum RadioValue { FIRST, SECOND, THIRD }

class EasyAlertRadio extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<EasyAlertRadio> {
  RadioValue _gValue = RadioValue.FIRST;

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Column(
          children: [
            RadioListTile(
              title: Text('雨の日に傘を持つようにレコメンドして！'),
              value: RadioValue.FIRST,
              groupValue: _gValue,
              onChanged: (value) {
                _onRadioSelected(value);
                print(value);
              },
            ),
            RadioListTile(
              title: Text('雨が降りそうになったら洗濯物を取り込むように言って！'),
              value: RadioValue.SECOND,
              groupValue: _gValue,
              onChanged: (value) => _onRadioSelected(value),
            ),
            RadioListTile(
              title: Text('災害が近いと避難するように言って！'),
              value: RadioValue.THIRD,
              groupValue: _gValue,
              onChanged: (value) => _onRadioSelected(value),
            ),
          ],
        ),
    );
  }

  _onRadioSelected(value) {
    setState(() {
      _gValue = value;
    });

  }
}