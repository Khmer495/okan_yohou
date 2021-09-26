import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okanyohou/util/color.dart';

enum RadioValue { FIRST, SECOND, THIRD }

//簡単設定
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
          SizedBox(
            height: 60,
            child: RadioListTile(
              title: Text('雨の日に傘を持つようにレコメンドして！'),
              value: RadioValue.FIRST,
              groupValue: _gValue,
              onChanged: (value) {
                _onRadioSelected(value);
                print(value);
              },
            ),
          ),
          SizedBox(
            height: 60,
            child: RadioListTile(
              title: Text('雨が降りそうになったら洗濯物を取り込むように言って！'),
              value: RadioValue.SECOND,
              groupValue: _gValue,
              onChanged: (value) => _onRadioSelected(value),
            ),
          ),
          SizedBox(
            height: 60,
            child: RadioListTile(
              title: Text('災害が近いと避難するように言って！'),
              value: RadioValue.THIRD,
              groupValue: _gValue,
              onChanged: (value) => _onRadioSelected(value),
            ),
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

// 現在地か
class PlaceAlertRadio extends StatefulWidget {
  @override
  _PlaceAlertRadioState createState() => _PlaceAlertRadioState();
}

class _PlaceAlertRadioState extends State<PlaceAlertRadio> {
  RadioValue _gValue = RadioValue.FIRST;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        SizedBox(
          height: 40,
          child: RadioListTile(
            title: Text('現在地を登録'),
            value: RadioValue.FIRST,
            groupValue: _gValue,
            onChanged: (value) {
              _onRadioSelected(value);
              print(value);
            },
          ),
        ),
        SizedBox(
          height: 40,
          child: RadioListTile(
            title: Text('場所を指定する'),
            value: RadioValue.SECOND,
            groupValue: _gValue,
            onChanged: (value) => _onRadioSelected(value),
          ),
        ),
        _gValue==RadioValue.SECOND
            ?TextField(
            keyboardType: TextInputType.text,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardAppearance: Brightness.light,
            maxLines: 1,
            style:
            TextStyle(fontSize: 16.0, color: Colors.black), //入力文字のサイズと色
            decoration: InputDecoration(
              filled: true,
              fillColor: ConstantsColors.gray2,
              hintText: '表示される名前（登録後変更可）',
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
            })
            :Container()
      ],
    );
  }

  _onRadioSelected(value) {
    setState(() {
      _gValue = value;
    });

  }
}

// 風速
class WindAlertRadio extends StatefulWidget {
  @override
  _WindAlertRadioState createState() => _WindAlertRadioState();
}

class _WindAlertRadioState extends State<WindAlertRadio> {
  RadioValue _gValue = RadioValue.FIRST;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        SizedBox(
          height: 40,
          child: RadioListTile(
            title: Text('強風'),
            value: RadioValue.FIRST,
            groupValue: _gValue,
            onChanged: (value) {
              _onRadioSelected(value);
              print(value);
            },
          ),
        ),
        SizedBox(
          height: 40,
          child: RadioListTile(
            title: Text('普通'),
            value: RadioValue.SECOND,
            groupValue: _gValue,
            onChanged: (value) => _onRadioSelected(value),
          ),
        ),
        SizedBox(
          height: 40,
          child: RadioListTile(
            title: Text('低気圧'),
            value: RadioValue.SECOND,
            groupValue: _gValue,
            onChanged: (value) => _onRadioSelected(value),
          ),
        ),
      ],
    );
  }

  _onRadioSelected(value) {
    setState(() {
      _gValue = value;
    });

  }
}

// 湿度
class HumidityAlertRadio extends StatefulWidget {
  @override
  _HumidityAlertRadioState createState() => _HumidityAlertRadioState();
}

class _HumidityAlertRadioState extends State<HumidityAlertRadio> {
  RadioValue _gValue = RadioValue.FIRST;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        SizedBox(
          height: 40,
          child: RadioListTile(
            title: Text('いつもよりじめじめ'),
            value: RadioValue.FIRST,
            groupValue: _gValue,
            onChanged: (value) {
              _onRadioSelected(value);
              print(value);
            },
          ),
        ),
        SizedBox(
          height: 40,
          child: RadioListTile(
            title: Text('いつもどおり'),
            value: RadioValue.SECOND,
            groupValue: _gValue,
            onChanged: (value) => _onRadioSelected(value),
          ),
        ),
        SizedBox(
          height: 40,
          child: RadioListTile(
            title: Text('いつもよりカラッと'),
            value: RadioValue.SECOND,
            groupValue: _gValue,
            onChanged: (value) => _onRadioSelected(value),
          ),
        ),
      ],
    );
  }

  _onRadioSelected(value) {
    setState(() {
      _gValue = value;
    });

  }
}

// 気圧
class PressAlertRadio extends StatefulWidget {
  @override
  _PressAlertRadioState createState() => _PressAlertRadioState();
}

class _PressAlertRadioState extends State<PressAlertRadio> {
  RadioValue _gValue = RadioValue.FIRST;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        SizedBox(
          height: 40,
          child: RadioListTile(
            title: Text('高気圧'),
            value: RadioValue.FIRST,
            groupValue: _gValue,
            onChanged: (value) {
              _onRadioSelected(value);
              print(value);
            },
          ),
        ),
        SizedBox(
          height: 40,
          child: RadioListTile(
            title: Text('普通'),
            value: RadioValue.SECOND,
            groupValue: _gValue,
            onChanged: (value) => _onRadioSelected(value),
          ),
        ),
        SizedBox(
          height: 40,
          child: RadioListTile(
            title: Text('低気圧'),
            value: RadioValue.SECOND,
            groupValue: _gValue,
            onChanged: (value) => _onRadioSelected(value),
          ),
        ),
      ],
    );
  }

  _onRadioSelected(value) {
    setState(() {
      _gValue = value;
    });

  }
}

// 体感
class FeelAlertRadio extends StatefulWidget {
  @override
  _FeelAlertRadioState createState() => _FeelAlertRadioState();
}

class _FeelAlertRadioState extends State<FeelAlertRadio> {
  RadioValue _gValue = RadioValue.FIRST;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        SizedBox(
          height: 40,
          child: RadioListTile(
            title: Text('いつもより暑い'),
            value: RadioValue.FIRST,
            groupValue: _gValue,
            onChanged: (value) {
              _onRadioSelected(value);
              print(value);
            },
          ),
        ),
        SizedBox(
          height: 40,
          child: RadioListTile(
            title: Text('普通'),
            value: RadioValue.SECOND,
            groupValue: _gValue,
            onChanged: (value) => _onRadioSelected(value),
          ),
        ),
        SizedBox(
          height: 40,
          child: RadioListTile(
            title: Text('いつもより寒い'),
            value: RadioValue.SECOND,
            groupValue: _gValue,
            onChanged: (value) => _onRadioSelected(value),
          ),
        ),
      ],
    );
  }

  _onRadioSelected(value) {
    setState(() {
      _gValue = value;
    });

  }
}