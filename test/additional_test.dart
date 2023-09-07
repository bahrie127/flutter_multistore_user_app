import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Calculator: addition function', () {
    // Arrange
    final calculator = Calculator();

    // Act
    final result = calculator.add(2, 2);

    // Assert
    expect(result, 4);
  });
}

class Calculator {
  int add(int param1, int param2) {
    return param1 + param1;
  }
}
