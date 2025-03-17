# 1주차 - Flutter 설치 및 구동

다음은 Flutter로 간단한 "Hello World"를 출력하는 코드입니다.    

## 📖코드

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
```

## 🖥️결과
<img src="./app/hello.png" width="50%" height="40%" alt="결과창"></img>

# 2주차 - Dart개념 및 실습

실습문제 풀어보기

## 📖실습문제1 - 구구단

```dart
void main() {
  for (int i = 1; i <= 9; i++) {
    for (int j = 1; j <= 9; j++) {
      print("$i x $j = ${i * j}");
    }
    print("");
  }
}

void printDan(int dan) {
  for (var j = 1; j <= 9; j++) {
    print('$dan * $j = ${dan * j}');
  }
}
```


