
import 'package:bee_tracker/Data_class/classcret.dart';
import 'package:flutter/material.dart';
import 'package:bee_tracker/Main/graphs_page.dart';
import 'package:bee_tracker/Graphs/humid_graph.dart';
import 'package:bee_tracker/Graphs/temp_graph.dart';
import 'package:bee_tracker/Graphs/sound_graph.dart';
import 'package:bee_tracker/Graphs/weight_graph.dart';
import 'package:bee_tracker/Data_class/sensor_value.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:bee_tracker/my_hives/hive_page.dart';
import 'dart:async';



class ListPage extends StatefulWidget {
  ListPage({Key key}) : super(key: key);

  final String title='Data';

  @override
  _ListPageState createState() => _ListPageState();
}
final sensorRef = FirebaseDatabase.instance.reference().child('Sensors');

class _ListPageState extends State<ListPage> {
  List data;
  String _humidity = '0.0';
  String _sound = '0.0';
  String _temp = '0.0';
  String _weight = '0.0';

  StreamSubscription<Event> _onEntryAddedSubscription;


  _onEntryAdded(Event event) {
    SensorValue sensorValue = SensorValue.fromSnapshot(event.snapshot);

    setState(() {
      _weight =sensorValue.weight;
      _temp = sensorValue.temp;
      _humidity =sensorValue.humidity;
      _sound = sensorValue.sound;

      data = getDatums();
    });
  }


  @override
  void initState() {
    data = getDatums();
    super.initState();
    _onEntryAddedSubscription = sensorRef.onChildAdded.listen(_onEntryAdded);

  }

  @override
  void dispose() {
  _onEntryAddedSubscription.cancel();

  super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Datum datum) =>
        ListTile(
          contentPadding:
          EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.autorenew, color: Colors.white),
          ),
          title: Text(
            datum.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),

          subtitle: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    // tag: 'hero',
                    child: LinearProgressIndicator(
                        backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                        value: datum.indicatorValue,
                        valueColor: AlwaysStoppedAnimation(Colors.green)),
                  )),
              Expanded(
                flex: 4,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(datum.level,
                        style: TextStyle(color: Colors.white))),
              )
            ],
          ),
          trailing:
          Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailPage(datum: datum)));
          },
        );

    Card makeCard(Datum datum) =>
        Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(datum),

          ),
        );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(data[index]);
        },
      ),
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
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        )
      ],
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: makeBody,
      bottomNavigationBar: makeBottom,
    );
  }


  List getDatums() {

    return [
      Datum(
          title: "Temperature (°C)",
          level: "Status",
          indicatorValue: double.tryParse(_temp)/25,
          value: _temp,
          content: temp_graph()),

      Datum(
          title: "Humidity (RH)",
          level: "Status",
          indicatorValue:double.tryParse(_humidity)/100,
          value: _humidity,
          content: humid_graph()),


      Datum(
          title: "Weight (g)",
          level: "Status",
          indicatorValue: double.tryParse(_weight)/ 1000,
          value: _weight,
          content: weight_graph()),

      Datum(
          title: "Sound (Hertz)",
          level: "Status",
          indicatorValue: double.tryParse(_sound)/ 1024,
          value: _sound,
          content: sound_graph()),
    ];
  }
}


