import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:project_manga/pages/profile_page.dart';
import 'package:project_manga/pages/clock_page.dart';
import 'package:project_manga/pages/currency_page.dart';
import 'package:project_manga/pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Other Page',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OtherPage(),
    );
  }
}

class OtherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Other',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.yellow,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  if (index == 3) {
                    return Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.remove('username');
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                                  (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            primary: Colors.blue,
                            elevation: 0,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey),
                              ),
                            ),
                            child: Text(
                              _getPageTitle(index),
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(height: 4.0),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (index == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProfilePage()),
                            );
                          } else if (index == 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ClockPage()),
                            );
                          } else if (index == 2) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CurrencyConverterPage()),
                            );
                          } else if (index == 3) {
                            Navigator.pushNamed(context, '/logout');
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey),
                            ),
                          ),
                          child: Text(
                            _getPageTitle(index),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(height: 4.0), // Add some spacing between items
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getPageTitle(int index) {
    switch (index) {
      case 0:
        return 'Profile';
      case 1:
        return 'Clock';
      case 2:
        return 'Currency Converter';
      case 3:
        return 'Logout';
      default:
        return '';
    }
  }
}
