void test1(String? firstName, String? middleName, String? lastName) {
  final firstNonNullValue =
      firstName ?? middleName ?? lastName; //Searches for 1st non-null value

  print(firstNonNullValue);
}

void test2(String? firstName, String? middleName, String? lastName) {
  String? name = firstName;

  name ??= middleName;
  name ??= lastName;
  print(name); //Null-aware assignment operator
}

void test3(List<String>? names) {
  final numberOfNames = names
      ?.length ?? 0; //Conditional invocation (allows us to use that data type properties even if null)

  print(numberOfNames);
}

void main() {
  String? name = null;
  int? age = null;
  List<String>? names1; //List can be null
  List<String?> names2 = [
    'Foo',
    'Bar',
    null
  ]; //List of strings can contain null
  List<String?>? names3 = ['Foo', 'Bar', null]; //Both combines

  print('$name, $age');
  name = "Foo";
  age = 20;
  print('$name, $age, $names1, $names2, $names3');
  names3 = null;
  print(names3);
  test1(null, null, "Baz");
  test1(null, null, null);
  test2(null, 'Bar', 'Baz');
  test2(null, null, 'Baz');
  test2('Foo', 'Bar', 'Baz');
  test2('Foo', null, 'Baz');
  test3(null);
  test3(['Foo']);
}
