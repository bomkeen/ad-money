import 'package:flutter/material.dart';
import 'package:ab_money/utils/database_helper.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper.internal();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Card(
//          color: Colors.pink,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(child: Icon(Icons.edit)),
                    Expanded(
                      flex: 5,
                      child: Text(
                        'เมนูตั้งค่าการใช้งาน',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                  leading: Icon(Icons.ac_unit),
                  title: Text('ข้อมูลส่วนตัว'),
                  subtitle: Text('จัดการข้อมูลส่วนตัว'),
                  trailing: Icon(Icons.keyboard_arrow_right)),
              ListTile(
                  leading: Icon(Icons.vpn_key),
                  title: Text('เปลี่ยนรหัสผ่าน'),
                  subtitle: Text('จัดการรหัสผ่านการเข้าใช้งานapp'),
                  trailing: Icon(Icons.keyboard_arrow_right)),
              ListTile(
                leading: Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                ),
                title: Text('ลบฐานข้อมูล'),
                trailing: IconButton(
                    icon: Icon(Icons.keyboard_arrow_right),
                    onPressed: () {
                      databaseHelper.removeDb();
                    }),
              )
            ],
          ),
        ),
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'ทดสอบ',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              ListTile()
            ],
          ),
        )
      ],
    );
    ;
  }
}
