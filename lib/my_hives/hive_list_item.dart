import 'package:bee_tracker/Data_class/hives_entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HivesListItem extends StatelessWidget {
  final HivesEntry hivesEntry;

  HivesListItem(this.hivesEntry);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          new Expanded(
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Column(
                  children: [
                    new Text(
                      new DateFormat.MMMEd().format(hivesEntry.dateTime),
                      textScaleFactor: 0.9,
                      textAlign: TextAlign.left,
                      style: TextStyle(color:Colors.white,
                    ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                ),
              ],
            ),
          ),
          new Text(
            hivesEntry.hivename,
            textScaleFactor: 1.0,
            textAlign: TextAlign.center,
            style: TextStyle(color:Colors.white,
            ),
          ),
          new Expanded(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Text(
                  hivesEntry.location,
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
