import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:ab_money/utils/database_helper.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  var id;
  DateTime Date;
  String strDate;
//  DateTime date;
  final _formkey = GlobalKey<FormState>();
  DatabaseHelper databaseHelper = DatabaseHelper.internal();
  TextEditingController ctrMoney = TextEditingController();
  TextEditingController ctrDate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DateTime _currentDate;
    int _year = DateTime.now().year;
    int _month = DateTime.now().month;
    int _day = DateTime.now().day;
    String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    Future<Null> _showDatePicker() async {
      final DateTime picked = await showDatePicker(
          locale: const Locale('th'),
          context: context,
          initialDate: DateTime(_year, _month, _day),
          firstDate: new DateTime(1920, 1, 1),
          lastDate: new DateTime(_year, _month, _day));
      if (picked != null && picked != _currentDate) {
        setState(() {
          var strDate = new DateFormat.MMMMd('th_TH')
              .format(new DateTime(picked.year, picked.month, picked.day));
          strDate = '$strDate ${picked.year + 543}';
          Date = picked;
        });
      }
    }

    Future<Null> saveData() async {
      print(ctrMoney.text);
      DateTime _date =
          DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
      var strDate = new DateFormat.MMMMd('th_TH')
          .format(new DateTime(_date.year, _date.month, _date.day));
      strDate = '$strDate ${_date.year + 543}';
      print('$strDate');
      String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      if (_formkey.currentState.validate()) {
        Map list = {
          'income': ctrMoney.text,
          'outcome': '0',
          'date': '$strDate',
//          'id': id
        };
        await databaseHelper.saveData(list);
//        if (id != null) {
//          await databaseHelper.updateData(member);
//        } else {
//          await databaseHelper.saveData(member);
//        }
        Navigator.of(context).pop({'ok': true});
//        print('ok');
      } else {
        print('Faile');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('บันทึกรายรับ'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                saveData();
//                Navigator.of(context).pop({'id': 1000, 'name': 'peeragad'});
              })
        ],
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //เรียกใชช้ theme defult จาก flutter
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'บันทึกการจ่ายเงิน',
                    style: TextStyle(fontSize: 25.0, color: Colors.brown),
                  ),
                ),
                Divider(),
                Padding(
                    padding: EdgeInsets.all(50.0),
                    child: Form(
                        key: _formkey,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '$formattedDate',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                FlatButton(
                                    onPressed: () => _showDatePicker(),
                                    child: Text(
                                      'เลืกวันที่',
                                      style: TextStyle(fontSize: 20.0),
                                    ))
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
//                                        labelText: 'First Name',
                                        labelStyle: TextStyle(fontSize: 20.0)),
                                    controller: ctrMoney,
                                    validator: (String value) {
                                      if (value.isEmpty)
                                        return 'กรุณาระบุข้อมูล';
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        saveData();
                      },
                      child: Icon(Icons.save),
                      color: Colors.pinkAccent.shade50,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
