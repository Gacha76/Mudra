enum PersonProperties { firstName, lastName, age }

enum AnimalType { cat, dog, bunny }

void test1(AnimalType animalType) {
  switch (animalType) {
    case AnimalType.bunny:
      print('Bunny');
      break;
    case AnimalType.cat:
      print('Cat');
      break;
    case AnimalType.dog:
      print('Dog');
      break;
    default:
      print("Not valid animal type");
  }
}

class Person {
  final String name;

  Person(this.name);

  void run() {
    print("Running");
  }

  void breathe() {
    print("Breathing");
  }

  void printName() {
    print(this.name);
  }
}

void test2() {
  final person = Person("Foo bar");

  person.run();
  person.breathe();
  person.printName();
}

abstract class LivingThing {
  void breathe() {
    print("Living thing is breathing");
  }

  void move() {
    print("I am moving");
  }
}

class Cat extends LivingThing {
  final String name;

  Cat(this.name);
  factory Cat.furball() {
    //Factory Constructor
    return Cat("Furball");
  }

  @override
  bool operator ==(covariant Cat other) => other.name == name;

  @override
  int get hashCode => name.hashCode;

  void meow() {
    print('meow');
  }

  void printName() {
    print(this.name);
  }
}

void test3() {
  final cat = Cat('Furball');
  final cat2 = Cat.furball();
  //final thing = LivingThing(); //abstract classes can't be instantiated & only used for inheritance

  cat.meow();
  cat.breathe();
  cat.move();
  cat.printName();
  if (cat.name == cat2.name) {
    print("They are equal");
  }
}

void main() {
  print(PersonProperties.firstName.name);
  print(PersonProperties.firstName);
  test1(AnimalType.cat);
  test2();
  test3();
}
