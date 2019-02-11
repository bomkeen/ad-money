import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:ab_money/utils/database_helper.dart';

class AddOutcome extends StatefulWidget {
  @override
  _AddOutcomeState createState() => _AddOutcomeState();
}

class _AddOutcomeState extends State<AddOutcome> {
  var id;
  var strDate =
      '${(DateFormat.MMMMd('th_TH').format(DateTime.now()))} ${DateTime.now().year + 543}';
  final _formkey = GlobalKey<FormState>();
  DatabaseHelper databaseHelper = DatabaseHelper.internal();
  TextEditingController ctrMoney = TextEditingController();
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    DateTime _currentDate;
    int _year = DateTime.now().year;
    int _month = DateTime.now().month;
    int _day = DateTime.now().day;
    Future<Null> _showDatePicker() async {
      final DateTime picked = await showDatePicker(
          locale: const Locale('th'),
          context: context,
          initialDate: DateTime(_year, _month, _day),
          firstDate: new DateTime(1920, 1, 1),
          lastDate: new DateTime(_year, _month, _day));
      if (picked != null && picked != _currentDate) {
        setState(() {
          strDate = new DateFormat.MMMMd('th_TH')
              .format(new DateTime(picked.year, picked.month, picked.day));
          strDate = '$strDate ${picked.year + 543}';
          formattedDate = DateFormat('dd-MM-yyyy')
              .format(DateTime(picked.year, picked.month, picked.day));
          print('$formattedDate formatteddate on datepicker');
          print('$strDate str date on datepicker');
        });
      }
    }

    Future<Null> saveData() async {
      print(ctrMoney.text);
//      print('testsave');
//      DateTime _date =
//          DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
//      var strDate = new DateFormat.MMMMd('th_TH')
      // .format(new DateTime(_date.year, _date.month, _date.day));
//      DateTime date = '$strDate ${_date.year + 543}';
//      strDate = '$strDate ${_date.year + 543}';
//      print('$strDate');
//      print('save outcome complate');

      if (_formkey.currentState.validate()) {
        Map list = {
          'income': '0',
          'outcome': ctrMoney.text,
          'date': formattedDate,
//          'id': id
        };
        await databaseHelper.saveoutcome(list);
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
        title: Text('บันทึกรายจ่าย'),
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
                                  strDate,
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                FlatButton(
                                    onPressed: () => _showDatePicker(),
                                    child: Icon(
                                      Icons.date_range,
                                      color: Colors.pink,
                                      size: 40.00,
                                    )),
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
