//꽉 찬 사각형
void main() {
  var n = 10; 
  var result = ""; 
  for (var y = 0; y < n; y++) {
    for (var x = 0; x < n; x++) {
      result += "•"; // 모든 위치에 "•" 출력
    }
    result += "\n"; // 줄 바꿈
  }
  print(result);
}


//테두리 사각형
void main() {
  var n = 10; 
  var result = ""; 
  for (var y = 0; y < n; y++) {
    for (var x = 0; x < n; x++) {
      if (y == 0 || y == n - 1 || x == 0 || x == n - 1) {
        result += "•"; // 테두리 위치에만 "•" 출력
      } else {
        result += " "; // 내부는 빈 칸
      }
    }
    result += "\n"; // 줄 바꿈
  }
  print(result);
}


// /표시
void main() {
  var n = 10;
  var result = "";

  for (var y = 0; y < n; y++) {
    for (var x = 0; x < n; x++) {
      if (y == 0 || y == n - 1 || x == 0 || x == n - 1) {
        result += "•"; // 테두리
      } else if (x == n - y - 1) {
        result += "•"; // 반대 대각선
      } else {
        result += " "; // 나머지는 빈 칸
      }
    }
    result += "\n"; // 줄 바꿈
  }
  print(result);
}




// |표시
void main() {
  var n = 10;
  var result = "";

  for (var y = 0; y < n; y++) {
    for (var x = 0; x < n; x++) {
      if (y == 0 || y == n - 1 || x == 0 || x == n - 1) {
        result += "•"; // 테두리
      } else if (x == y) {
        result += "•"; // 대각선
      } else {
        result += " "; // 나머지는 빈 칸
      }
    }
    result += "\n"; // 줄 바꿈
  }
  print(result);
}

//x표시

void main() {
  var n = 10;
  var result = "";

  for (var y = 0; y < n; y++) {
    for (var x = 0; x < n; x++) {
      if (y == 0 || y == n - 1 || x == 0 || x == n - 1) {
        result += "•"; // 테두리
      } else if (x == y || x == n - y - 1) {
        result += "•"; // X 모양
      } else {
        result += " "; // 나머지는 빈 칸
      }
    }
    result += "\n"; // 줄 바꿈
  }
  print(result);
}
