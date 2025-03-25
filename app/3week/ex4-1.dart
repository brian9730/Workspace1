class Person {
  String name="";
  int age =0;
 
  void addOneYear() {
age ++;
  }
}
void main() {
  var na=Person();
  na.name='최민기';
  na.age=22;
  print([na.name, na.age]);
}

결과: [최민기, 22]
