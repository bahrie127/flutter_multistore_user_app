import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('test http get request', () async {
    //arrange
    int statucCodeOk = 200;
    
    //act, make the request
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    //assert, verify the status code
    expect(response.statusCode, statucCodeOk);
  });
}
