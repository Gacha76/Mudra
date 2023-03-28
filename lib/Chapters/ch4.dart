String getFullName(String firstName, String lastName) {
  //return firstName + ' ' + lastName;
  return '$firstName $lastName';
}

String getFullName2(String firstName, String lastName) =>
    '$firstName $lastName';

input1() => [1, 2];
input2() => const [1, 2];

void printMyName(String firstName, String lastName) {
  print('Name : $firstName $lastName');
}

void variable() {
  final int age = 20;
  var age1 = age + 10,
      age2 = age - 10,
      age3 = age * 2,
      age4 = age / 2,
      age5 = age % 2,
      age6 = --age5,
      age7 = age5++;

  print('$age, $age1, $age2, $age3, $age4, $age5, $age6, $age7');
}

void ifelse() {
  final String name = 'Foo';
  final nameTimes20 = name * 20;

  if (name == 'Foo') {
    print("Yes this is foo");
  } else if (name != 'Bar') {
    print("No this is not bar");
  } else {
    print('I don\'t know what this is');
  }

  print(nameTimes20);
}

void listandset() {
  var names = ['Foo', 'Bar', 'Baz', 1, 5.5]; //List
  final foo = names[0];

  print('$foo, ${names.length}, $names, ${names[0]}');
  names.add('My name');
  print('${names[5]}, ${names.length}');

  var setNames = {'foo', 'bar', 'baz', 1}; //Set
  setNames.add('foo');
  print(setNames);
}

void map() {
  var person = {'age': 20, 'name': 'Foo'}; //Map (same as a dictionary)

  print(person);
  print("${person['age']},${person['name']}");
  person['name'] = "FOOOOOO";
  print(person);
}

const age = 27; //compile-time constant
const twiceTheAge = age * 2;
void main() {
  var name = "Alex"; //variable
  final name2 = "Henry"; //run-time constant

  final x1 = input1();
  final x2 = input1();
  var y1 = input2();
  var y2 = input2();

  print('${x1 == x2}, ${y1 == y2}');

  for (int i = 0; i < 5; i++) {
    print('hello ${i + 1}');
  }
  printMyName('Foo', 'Bar');
  print(getFullName('Foo', 'Bar'));
  print(getFullName2('Foo', 'Bar'));
  variable();
  ifelse();
  listandset();
  map();
}
