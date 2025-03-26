class Person {
-> 클래스 필드 이름 앞에 _를 불티는 것은 다수의 언어에서 사용하는 스타일
  String _name;
  int _age;
  String _desc;

 
  Person(this._name, this._age, this._desc);
 
 
 
  void addOneYear() {
    _age ++;
  }
 
  String get name => _name;
  int get age => _age;
  String get desc => _desc;
  set desc(String v) => _desc =v;
}

void main() {
  var na=Person('최민기', 22, ' 최민기짱 ');
 
  print([na.name, na.age, na.desc]);
  na.addOneYear();
  na.desc='아니다 최민기는 짱짱이다!';
  print([na.name, na.age, na.desc]);
}


결과: [최민기, 22,  최민기짱 ]
[최민기, 23, 아니다 최민기는 짱짱이다!]
