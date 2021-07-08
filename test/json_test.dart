import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test("parsing item.json over a network", () async {
    var url = "https://jsonplaceholder.typicode.com/photos";
    final res = await http.get(url);
    expect(res.statusCode, 404);
  });
}
