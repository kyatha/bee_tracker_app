import 'package:firebase_database/firebase_database.dart';

class SensorValue {
  String _id;
  DateTime _dateTime;
  String _temp;
  String _humidity;
  String _sound;
  String _weight;

  SensorValue(this._id, this._dateTime,this._temp, this._humidity, this._sound, this._weight);

  SensorValue.map(dynamic obj) {
    this._id = obj['id'];
    this._dateTime = obj['Date'];
    this._temp = obj['Temperature'];
    this._humidity = obj['Humidity'];
    this._sound = obj['Sound'];
    this._weight = obj['Weight'];
  }

  String get id => _id;
  DateTime get dateTime => _dateTime;
  String get temp => _temp;
  String get humidity => _humidity;
  String get sound => _sound;
  String get weight => _weight;

  SensorValue.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _dateTime =
    new DateTime.fromMillisecondsSinceEpoch(snapshot.value["Date"]);
    _temp = snapshot.value['Temperature'].toString();
    _humidity = snapshot.value['Humidity'].toString();
    _sound = snapshot.value['Sound'].toString();
    _weight = snapshot.value['Weight'].toString();
  }
}