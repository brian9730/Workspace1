class Rectangle {
-> 사각형을 왼쪽, 상단, 너비, 높이로 표현
  num left, top, width, height;
  Rectangle(this.left, this.top, this.width, this.height);

-> 오른쪽, 하단은 필드를 생성하지 않고 get/set 으로 계산하여 표현
  num get right => left + width;
  set right(num value) => left= value - width;
  num get bottom => top + height;
  set bottomm(num value) => top = value - height;
}
 

void main() {
  var r1=Rectangle(5, 10, 20, 25);
  print([r1.left, r1.top, r1.width, r1.height]);
  print([r1.width, r1.height]);
}
-> left, top, width, height <-> left, top, right, bottom

결과: [5, 10, 20, 25]
[20, 25]