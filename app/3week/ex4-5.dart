class Hero {
  String name ='영웅';
 
  void run() {
print('뛴다');
  }
}
  class SuperHero extends Hero {
    @override
    void run() {
    super.run();
    this.fly();
    }
   
    void fly() {
      print('난다!');
    }
  }

void main() {
  var hero= SuperHero();
  hero.run();
  print(hero.name);
}


결과: 뛴다
난다!
영웅
