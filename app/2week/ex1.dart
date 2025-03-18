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


