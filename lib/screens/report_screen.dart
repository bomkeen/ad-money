import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ab_money/utils/database_helper.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper.internal();
  List items = [];
  Future getItems() async {
    var res = await databaseHelper.getList();
    print(res);
    setState(() {
      items = res;
    });
  }

  void initState() {
    super.initState();
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
//      appBar: AppBar(
//        title: Text('Member'),
//        actions: <Widget>[
//          IconButton(icon: Icon(Icons.photo_camera), onPressed: () {})
//        ],
//      ),
      body: ListView.builder(
          itemBuilder: (context, int index) {
            return ListTile(
//                onTap: () async {
//                  var response = await Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) =>
//                              AddMemberScreen(members[index]['id'])));
//                  if (response != null) {
//                    getMembers();
//                  }
//                },
                title: Text('${items[index]['date']}'),
                subtitle: Text(
                    '${items[index]['income']}----${items[index]['outcome']}'),
                trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
//                      removeMembers(members[index]['id']);
                    }));
          },
          itemCount: items != null ? items.length : 0),
      floatingActionButton: FloatingActionButton(
        //// ใช้แบบนี เพราะมีการส่งค่า กลับบมา ตอนกด save
        onPressed: () async {
//          var response = await Navigator.push(context,
//              MaterialPageRoute(builder: (context) => AddMemberScreen(null)));
//          if (response != null) {
//            getMembers();
//          }
        },
        child: Icon(Icons.person_add),
      ),
    );
  }
}
