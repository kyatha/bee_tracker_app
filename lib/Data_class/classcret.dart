import 'package:flutter/cupertino.dart';

class Datum {
  String title;
  String level;
  double indicatorValue;
  Widget content;
  String value;

  Datum(
      {this.title, this.level, this.indicatorValue, this.content, this.value});
}
