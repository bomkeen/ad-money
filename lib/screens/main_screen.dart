import 'package:ab_money/screens/home_screen.dart';
import 'package:ab_money/screens/report_screen.dart';
import 'package:ab_money/screens/setting_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  List pages = [HomeScreen(), ReportScreen(), SettingScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ระบบบันทึกบัญชีรายวัน',
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
            color: Colors.white,
            iconSize: 30.0,
          )
        ],
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {},
//        child: Icon(Icons.attach_money),
//      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.home,
              color: Colors.pinkAccent,
              size: 30.0,
            ),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.restore_page,
              color: Colors.pinkAccent,
              size: 30.0,
            ),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.settings,
              color: Colors.pinkAccent,
              size: 30.0,
            ),
            title: new Text('Setting'),
          ),
        ],
      ),
    );
  }
}
