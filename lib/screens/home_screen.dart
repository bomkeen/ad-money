import 'package:ab_money/screens/add_outcome.dart';
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
  void initState() {
    super.initState();
    getSum();
    getOutcome();
    getBalance();
    ;
  }

  DatabaseHelper databaseHelper = DatabaseHelper.internal();
  int income_sum;
  int outcome_sum;
  int balance;

  Future getSum() async {
    var res = await databaseHelper.getSum();
    setState(() {
      income_sum = res[0]['sum'];
      print(res[0]['sum']);
      print('${income_sum}');
      getBalance();
    });
  }

  Future getBalance() async {
    var res = await databaseHelper.getBalance();
    setState(() {
      balance = res[0]['sum'];
      print(res[0]['sum']);
      print('${balance}');
    });
  }

  Future getOutcome() async {
    var res = await databaseHelper.getOutcomeSum();
    setState(() {
      outcome_sum = res[0]['sum'];

      print('${outcome_sum}');
      getBalance();
    });
  }

  String formattedDate =
      DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

  @override
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
                '$outcome_sum',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40.00, color: Colors.red),
              ),
              Text(
                '$income_sum',
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
              onPressed: () async {
                var response = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddOutcome()));
                if (response != null) {
                  getOutcome();
                }
              },
              child: Icon(
                Icons.delete_forever,
                size: 30.00,
              ),
            ),
            new RaisedButton(
                onPressed: () async {
                  var response = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddScreen()));
                  if (response != null) {
                    getSum();
                  }
                },
                textColor: Colors.white,
                color: Colors.green,
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.add_circle,
                  size: 30.00,
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$balance',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40.00, color: Colors.red),
            ),
          ],
        )
      ],
    );
  }
}
