import 'package:firebase_database/firebase_database.dart';

class HivesEntry {
  String key;
  DateTime dateTime;
  String hivename;
  String location;

  HivesEntry(this.dateTime, this.hivename, this.location);

  HivesEntry.map(dynamic obj) {
    this.dateTime = obj['date'];
    this.hivename = obj['hive_name'];
    this.location = obj['location'];
  }

  HivesEntry.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        dateTime =
        new DateTime.fromMillisecondsSinceEpoch(snapshot.value["date"]),
        hivename = snapshot.value["hive_name"].toString(),
        location = snapshot.value["location"].toString();

  toJson() {
    return {
      "hive_name": hivename,
      "date": dateTime.millisecondsSinceEpoch,
      "location": location
    };
  }
}
