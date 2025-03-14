# Flutter 설치 및 구동

다음은 Flutter로 간단한 "Hello World"를 출력하는 코드입니다.

# 📖코드

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
             'Hello World',
          ),
        ),
      ),
    )
  );
}

