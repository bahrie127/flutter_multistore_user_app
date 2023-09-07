import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      'Calculate Circle Area: function should return circle area based on radius',
      () {
    //arrange
    final radius = 5;
    //act
    final result = calculateCircleArea(radius);
    // assert
    expect(78.5, result);
  });
}

num calculateCircleArea(num radius) {
  num pi = 3.14;

  return pi * radius * radius;
}
