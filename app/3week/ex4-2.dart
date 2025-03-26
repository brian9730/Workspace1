class Person {
  String _name="";
  int _age =0;
 
  Person(this._name, this._age);
 
 
 
  void addOneYear() {
    _age ++;
  }
 
  String get name => _name;
  int get age => _age;
}

void main() {
  var na=Person('최민기', 22);
 
  print([na.name, na.age]);
}

결과: [최민기, 22]