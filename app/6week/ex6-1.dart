import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Blocks Layout',
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // 상단 레이아웃 (위 절반)
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    // 왼쪽 빨간 박스
                    Expanded(
                      flex: 2,
                      child: Container(color: Colors.red),
                    ),
                    // 오른쪽 박스 묶음
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          // 파란 박스
                          Expanded(
                            flex: 1,
                            child: Container(color: Colors.blue),
                          ),
                          // 검정 + 주황 박스
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(color: Colors.black),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(color: Colors.orange),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // 하단 노란 박스 (아래 절반)
              Expanded(
                flex: 1,
                child: Container(color: Colors.yellow),
              ),
            ],
          ),
        ),
      ),
    );
  }
}