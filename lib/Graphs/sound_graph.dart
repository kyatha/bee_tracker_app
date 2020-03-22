import 'package:flutter/material.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:firebase_database/firebase_database.dart';

class sound_graph extends StatefulWidget {
  @override
  _sound_graphState createState() {
    return _sound_graphState();
  }
}

final mainReference = FirebaseDatabase.instance.reference();

class _sound_graphState extends State<sound_graph> {
  List<double> sound_list = [];
  List<double> date_list = [];


  double sound;
  double datey;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseDatabase.instance
            .reference()
            .child("Sensors")
            .orderByKey()
            .limitToLast(24)
            .onValue,
        builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
          if (snapshot.hasData) {
            Map<dynamic, dynamic> values1 = snapshot.data.snapshot.value;


            values1.forEach((k, v) {

              double sound = double.parse(v["Sound"].toString());
              var datey = double.parse(v["Date"].toString());


              date_list.add(datey);

             sound_list.add(sound);
            });
            //date_list_up = DateFormat.yMd().add_Hms().format(date_list);


            return Center(
              child: Container(
                color: Colors.white,
                height: MediaQuery
                    .of(context)
                    .size
                    .height/2,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: BezierChart(
                  bezierChartScale: BezierChartScale.CUSTOM,
                  xAxisCustomValues: const [0,1,2,3,4,5,6,7,8,9,10,
                    11,12,13,14, 15, 16,17, 18,19,20,21,22,23],
                  footerValueBuilder: (double value) {
                    return "${value.toInt()}\nHrs";
                  },
                  series: [
                    BezierLine(
                      label: "Sound (Hz)",
                      data:  [
                        DataPoint<double>(value: sound_list[0], xAxis: date_list[0]),
                        DataPoint<double>(value: sound_list[1], xAxis: date_list[1]),
                        DataPoint<double>(value: sound_list[2], xAxis: date_list[2]),
                        DataPoint<double>(value: sound_list[3], xAxis: date_list[3]),
                        DataPoint<double>(value: sound_list[4], xAxis: date_list[4]),
                        DataPoint<double>(value: sound_list[5], xAxis: date_list[5]),
                        DataPoint<double>(value: sound_list[6], xAxis: date_list[6]),
                        DataPoint<double>(value: sound_list[7], xAxis: date_list[7]),
                        DataPoint<double>(value: sound_list[8], xAxis: date_list[8]),
                        DataPoint<double>(value: sound_list[9], xAxis: date_list[9]),
                        DataPoint<double>(value: sound_list[10], xAxis: date_list[10]),
                        DataPoint<double>(value: sound_list[11], xAxis: date_list[11]),
                        DataPoint<double>(value: sound_list[12], xAxis: date_list[12]),
                        DataPoint<double>(value: sound_list[13], xAxis: date_list[13]),
                        DataPoint<double>(value: sound_list[14], xAxis: date_list[14]),
                        DataPoint<double>(value: sound_list[15], xAxis: date_list[15]),
                        DataPoint<double>(value: sound_list[16], xAxis: date_list[16]),
                        DataPoint<double>(value: sound_list[17], xAxis: date_list[17]),
                        DataPoint<double>(value: sound_list[18], xAxis: date_list[18]),
                        DataPoint<double>(value: sound_list[19], xAxis: date_list[19]),
                        DataPoint<double>(value: sound_list[20], xAxis: date_list[20]),
                        DataPoint<double>(value: sound_list[21], xAxis: date_list[21]),
                        DataPoint<double>(value: sound_list[22], xAxis: date_list[22]),
                        DataPoint<double>(value: sound_list[23], xAxis: date_list[23]),
                      ],
                    ),
                  ],
                  config: BezierChartConfig(
                    verticalIndicatorStrokeWidth: 2.0,
                    verticalIndicatorColor: Colors.black26,
                    showVerticalIndicator: true,
                    backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                    contentWidth: MediaQuery.of(context).size.width * 2,
                    footerHeight: 40.0,
                  ),
                ),
              ),
            );
          }
          else
            return Container(
              child: new Text("No Data Yet, Check Internet connection"),
            );
        });
  }
  }
