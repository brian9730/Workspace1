import 'package:flutter/material.dart';
import 'dart:async'; // 타이머 사용을 위해 필요한 라이브러리
import 'dart:math'; // 랜덤 색상 생성을 위해 필요한 라이브러리

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CurrentTimeApp(),
    );
  }
}

class CurrentTimeApp extends StatefulWidget {
  @override
  _CurrentTimeAppState createState() => _CurrentTimeAppState();
}

class _CurrentTimeAppState extends State<CurrentTimeApp> {
  late String currentTime;
  Color currentColor = Colors.black; // 초기 텍스트 색상

  @override
  void initState() {
    super.initState();
    currentTime = _getCurrentTime();
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        currentTime = _getCurrentTime();
        currentColor = _getRandomColor(); // 색상 변경
      });
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.year}-${_twoDigits(now.month)}-${_twoDigits(now.day)}\n${now
        .hour > 12 ? '오전' : '오후'} ${_twoDigits(
        now.hour % 12 == 0 ? 12 : now.hour % 12)}:${_twoDigits(
        now.minute)}:${_twoDigits(now.second)}';
  }

  String _twoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }

  Color _getRandomColor() {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1, // 불투명 색상
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('현재 시각'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Text(
          currentTime,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: currentColor, // 텍스트 색상 갱신
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}