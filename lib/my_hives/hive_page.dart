import 'dart:async';
import 'dart:ui';
import 'package:bee_tracker/my_hives/hive_entry_dialog.dart';
import 'package:bee_tracker/my_hives/hive_list_item.dart';
import 'package:bee_tracker/Data_class/hives_entry.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:bee_tracker/Main/graphs_format.dart';


class HivesPage extends StatefulWidget {
  @override
  _HivesPageState createState() {
    return _HivesPageState();
  }
}

final hivesReference = FirebaseDatabase.instance.reference().child('hives');

class _HivesPageState extends State<HivesPage> {
  List<HivesEntry> hivesSaves = new List();
  ScrollController _listViewScrollController = new ScrollController();
  double _itemExtent = 50.0;

  _HivesPageState() {
    hivesReference.onChildAdded.listen(_onEntryAdded);
    hivesReference.onChildChanged.listen(_onEntryEdited);
  }

  @override
  Widget build(BuildContext context) {
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text("Hives"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        )
      ],
    );


    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.device_hub, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HivesPage()),
                );
              },
            ),

          ],
        ),
      ),
    );
    final makeBody = Container(
      decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)
      ),
      child: new ListView.builder(
        shrinkWrap: true,
        reverse: true,
        controller: _listViewScrollController,
        itemCount: hivesSaves.length,
        itemBuilder: (buildContext, index) {
         return Card(
           elevation: 8.0,
           margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
           child: Container(
             decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
             child:new ListTile(
            onTap: () => _openEditEntryDialog(hivesSaves[index]),
            title: new HivesListItem(hivesSaves[index]),

          ),
           ),
         );

          //calculating difference
        },
      ),
    );
    return new Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: makeBody,
      bottomNavigationBar: makeBottom,



      floatingActionButton: new FloatingActionButton(
        onPressed: _openAddEntryDialog,
        child: new Icon(Icons.add),
      ),
    );


  }

  _openEditEntryDialog(HivesEntry hivesEntry) {
    Navigator.of(context)
        .push(
      new MaterialPageRoute<HivesEntry>(
        builder: (BuildContext context) {
          return new HivesEntryDialog.edit(hivesEntry);
        },
        fullscreenDialog: true,
      ),
    )
        .then((HivesEntry newEntry) {
      if (newEntry != null) {
        hivesReference.child(hivesEntry.key).set(newEntry.toJson());
      }
    });
  }

  Future _openAddEntryDialog() async {
    HivesEntry entry =
    await Navigator.of(context).push(new MaterialPageRoute<HivesEntry>(
        builder: (BuildContext context) {
          return new HivesEntryDialog.add(
              hivesSaves.isNotEmpty ? hivesSaves.last.location : " ");
        },
        fullscreenDialog: true));
    if (entry != null) {
      hivesReference.push().set(entry.toJson());
    }
  }

  _onEntryAdded(Event event) {
    setState(() {
      hivesSaves.add(new HivesEntry.fromSnapshot(event.snapshot));
      hivesSaves.sort((we1, we2) => we1.dateTime.compareTo(we2.dateTime));
    });
    _scrollToTop();
  }

  _onEntryEdited(Event event) {
    var oldValue =
    hivesSaves.singleWhere((entry) => entry.key == event.snapshot.key);
    setState(() {
      hivesSaves[hivesSaves.indexOf(oldValue)] =
      new HivesEntry.fromSnapshot(event.snapshot);
      hivesSaves.sort((we1, we2) => we1.dateTime.compareTo(we2.dateTime));
    });
  }

  _scrollToTop() {
    _listViewScrollController.animateTo(
      hivesSaves.length * _itemExtent,
      duration: const Duration(microseconds: 1),
      curve: new ElasticInCurve(0.01),
    );
  }
}
