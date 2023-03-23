class Cat {
  final String name;

  Cat(this.name);
}

extension Run on Cat {
  void run() {
    print("Cat $name is running");
  }
}

class Person {
  final String firstName, lastName;

  Person(this.firstName, this.lastName);
}

extension FullName on Person {
  String get fullName => '$firstName $lastName';
}

void test1() {
  final meow = Cat('Furball');
  final foo = Person('Foo', 'Bar');

  print(meow.name);
  meow.run();
  print(foo.fullName);
}

Future<int> heavyFutureThatMultipliesByTwo(int a) {
  return Future.delayed(const Duration(seconds: 3), () {
    return a * 2;
  });
}

Stream<String> getName1() {
  return Stream.value('Foo');
}

Stream<String> getName2() {
  return Stream.periodic(const Duration(seconds: 1), (value) {
    return 'Foo';
  });
}

void test2() async {
  final result = await heavyFutureThatMultipliesByTwo(10);

  print(result);
  await for (final value in getName1()) {
    print(value);
  }
  print('Stream finished working');
  await for (final value in getName2()) {
    print(value);
  }
}

Iterable<int> getOneTwoThree() sync* {
  yield 1;
  yield 2;
  yield 3;
}

void test3() {
  print(getOneTwoThree());
  for (final value in getOneTwoThree()) {
    print(value);
    if (value == 2) break;
  }
}

class PairOfStrings {
  final String value1;
  final String value2;

  PairOfStrings(this.value1, this.value2);
}

class PairOfIntegers {
  final int value1;
  final int value2;

  PairOfIntegers(this.value1, this.value2);
}

class Pair<A, B> {
  final A value1;
  final B value2;

  Pair(this.value1, this.value2);
}

void test4() {
  final names = Pair('foo', 20);

  print('${names.value1} ${names.value2}');
}

void main() {
  //test1();
  //test2();
  //test3();
  test4();
}
