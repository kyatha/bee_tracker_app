import 'package:bee_tracker/Data_class/classcret.dart';
import 'package:flutter/material.dart';
import 'package:bee_tracker/my_hives/hive_page.dart';
import 'package:bee_tracker/Main/graphs_format.dart';
import 'package:bee_tracker/style/widget_utils.dart' show screenAwareSize;


class DetailPage extends StatelessWidget {
  final Datum datum;
  DetailPage({Key key, this.datum}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final levelIndicator = Container(
      child: Container(
        child: LinearProgressIndicator(
            backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
            value: datum.indicatorValue,
            valueColor: AlwaysStoppedAnimation(Colors.green)),
      ),
    );
    final sensorData = Container(
      padding: EdgeInsets.all(screenAwareSize(7.0,context)),
      width: 500,
      height: 40,
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: new Text(
        datum.value,
        style: TextStyle(color: Colors.white,
        fontSize:25,),
      ),
    );


    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 30.0),
        Icon(
          Icons.trending_up,
          color: Colors.white,
          size: 40.0,
        ),
        Container(
          width: 50.0,
          child: new Divider(color: Colors.green),
        ),
        SizedBox(height: 15.0),
        Text(
          datum.title,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        //SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: levelIndicator),
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: screenAwareSize(10.0, context)),
                    child: Text(
                      datum.level,
                      style: TextStyle(color: Colors.white),
                    ))),
            Expanded(flex:3, child: sensorData)//2
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: screenAwareSize(10.0, context)),
            height: MediaQuery.of(context).size.height * 0.1,
          ),
        Container(
          height: MediaQuery.of(context).size.height * 0.36,
          padding: EdgeInsets.all(screenAwareSize(30.0, context)),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 40.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context,MaterialPageRoute(builder: (context) => ListPage()),);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentGraphs = datum.content;

    final bottomContent = Container(
      height: 85.0,
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

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: Column(
        children: <Widget>[topContent,bottomContentGraphs, bottomContent],
      ),
    );
  }
}