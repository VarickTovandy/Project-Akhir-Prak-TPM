import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class ClockPage extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  late DateTime _currentTime;
  String _timeZone = 'Jakarta';
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        _currentTime = DateTime.now().add(Duration(hours: _getTimeZoneOffset()));
      });
    });
  }

  int _getTimeZoneOffset() {
    switch (_timeZone) {
      case 'Jakarta':
        return 0;
      case 'New York':
        return -4;
      case 'Japan':
        return 9;
      case 'London':
        return 1;
      default:
        return 0;
    }
  }

  void _changeTimeZone(String newTimeZone) {
    setState(() {
      _timeZone = newTimeZone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Clock',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.blue.withOpacity(0.3),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current Time',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              DateFormat('HH:mm:ss').format(_currentTime),
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Select Time Zone'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              _changeTimeZone('Jakarta');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey),
                                ),
                              ),
                              child: Text('Jakarta', style: TextStyle(color: Colors.black)),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              _changeTimeZone('New York');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey),
                                ),
                              ),
                              child: Text('New York', style: TextStyle(color: Colors.black)),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              _changeTimeZone('Japan');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey),
                                ),
                              ),
                              child: Text('Japan', style: TextStyle(color: Colors.black)),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              _changeTimeZone('London');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey),
                                ),
                              ),
                              child: Text('London', style: TextStyle(color: Colors.black)),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child:
              const Text('Change Time Zone', style: TextStyle(fontSize: 15)),
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF0A3F67),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
