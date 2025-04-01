abstract class Monster {
  void attack();
}
  class Goblin implements Monster {
    @override
    void attack () {
print('고블린 어택!');
    }
  }
  class Bat implements Monster {
   @override
   void attack () {
   print('할퀴기!');
   }
   }

void main() {
  Goblin g1 = Goblin();
  Bat b1= Bat();
  g1.attack();
  b1.attack();
 
 
  //monsters의 타입은?
  List<Monster> monsters = [g1, b1];
  monsters.forEach((m) => m.attack());
 
}


결과:
고블린 어택!
할퀴기!
고블린 어택!
할퀴기!