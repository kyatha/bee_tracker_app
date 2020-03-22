import 'dart:async';

import 'package:bee_tracker/Data_class/hives_entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';




class HivesEntryDialog extends StatefulWidget {
  final initialLocation;
  final HivesEntry hivesEntryToEdit;

  HivesEntryDialog.add(this.initialLocation) : hivesEntryToEdit = null;

  HivesEntryDialog.edit(this.hivesEntryToEdit)
      : initialLocation = hivesEntryToEdit.location;

  @override
  HivesEntryDialogState createState() {
    if (hivesEntryToEdit != null) {
      return new HivesEntryDialogState(hivesEntryToEdit.dateTime,
          hivesEntryToEdit.hivename, hivesEntryToEdit.location);
    } else {
      return new HivesEntryDialogState(
          new DateTime.now(), null, initialLocation);
    }
  }
}

class HivesEntryDialogState extends State<HivesEntryDialog> {
  DateTime _dateTime = new DateTime.now();
  String _hivename;
  String _location;

  TextEditingController _textController;
  TextEditingController _textController1;


  HivesEntryDialogState(this._dateTime,
      this._hivename,
      this._location,);

  Widget _createAppBar(BuildContext context) {
    return new AppBar(
      title: widget.hivesEntryToEdit == null
          ? const Text("New Hives")
          : const Text("Edit Hives"),
      actions: [
        new FlatButton(
          onPressed: () {
            Navigator.of(context)
                .pop(new HivesEntry(_dateTime, _hivename, _location));
          },
          child: new Text('SAVE',
              style: Theme
                  .of(context)
                  .textTheme
                  .subhead
                  .copyWith(color: Colors.white)),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _textController = new TextEditingController(text: _hivename);
    _textController1 = new TextEditingController(text: _location);
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _createAppBar(context),
      body: new Column(
        children: [
          new ListTile(
            leading: new Icon(Icons.today, color: Colors.black),
            title: new DateTimeItem(
              dateTime: _dateTime,
              onChanged: (dateTime) => setState(() => _dateTime = dateTime),
            ),
          ),
          new ListTile(
            leading: new Icon(Icons.speaker_notes, color: Colors.black),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: 'Hive Name',
              ),
              controller: _textController,
              onChanged: (value) => _hivename = value,
            ),
          ),
          new ListTile(
            leading: new Icon(Icons.add_location, color: Colors.black),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: 'Search Location',
              ),
              controller: _textController1,
              onChanged: (value) => _location = value,

            ),
          ),
        ],
      ),
    );
  }
}


class DateTimeItem extends StatelessWidget {
  DateTimeItem({Key key, DateTime dateTime, @required this.onChanged})
      : assert(onChanged != null),
        date = dateTime == null
            ? new DateTime.now()
            : new DateTime(dateTime.year, dateTime.month, dateTime.day),
//  ,
//        time = dateTime == null
//            ? new DateTime.now()
//            : new TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
        super(key: key);

  final DateTime date;

  //final TimeOfDay time;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new InkWell(
            onTap: (() => _showDatePicker(context)),
            child: new Padding(
                padding: new EdgeInsets.symmetric(vertical: 8.0),
                child: new Text(new DateFormat('EEEE, MMMM d').format(date))),
          ),
        ),
      ],
    );
  }

  Future _showDatePicker(BuildContext context) async {
    DateTime dateTimePicked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: date.subtract(const Duration(days: 20000)),
        lastDate: new DateTime.now());

    if (dateTimePicked != null) {
      onChanged(new DateTime(dateTimePicked.year, dateTimePicked.month));
      //dateTimePicked.day, time.hour, time.minute));
    }
  }

}


