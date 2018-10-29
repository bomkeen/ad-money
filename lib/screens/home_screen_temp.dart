import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ab_money/screens/add_screen.dart';
import 'package:ab_money/utils/database_helper.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//  int number = 0;
  List income_sum = []; // ignore: non_constant_identifier_names
//  int test;
  DatabaseHelper databaseHelper = DatabaseHelper.internal();

  Future getSum() async {
    var res = await databaseHelper.getSum();
//    var detail = res[0];
//    print('$res');
    setState(() {
      income_sum = res;
      print('$income_sum');
//      test = detail['sum'];
    });
  }

//  DateTime now = DateTime.now();
  String formattedDate =
      DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
//  void subtractNumbers() {
//    setState(() {
//      number = number - 1;
//    });
//  }

//  void addNumbers() {
//    setState(() {
//      number = number + 1;
//    });
//  }

  @override
  void initState() {
    super.initState();
    getSum();
  }

  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Row(
          children: <Widget>[Text('$formattedDate')],
        ),
        Container(
          padding: EdgeInsets.all(30.00),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                '',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40.00, color: Colors.red),
              ),

              Text(
                '${income_sum[0]}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40.00, color: Colors.greenAccent),
              ),

//              new Icon(Icons., size: 100.0),
//            new Icon(Icons.star, size: 50.0),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new RaisedButton(
              padding: const EdgeInsets.all(8.0),
              textColor: Colors.white,
              color: Colors.red,
              onPressed: () {},
              child: Icon(
                Icons.delete_forever,
                size: 30.00,
              ),
            ),
            new RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddScreen()),
                  );
                },
                textColor: Colors.white,
                color: Colors.green,
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.add_circle,
                  size: 30.00,
                )),
          ],
        )
      ],
    );
  }
}
