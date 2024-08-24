import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> makeHttpCall() async {
  final url = Uri.parse('http://localhost:8000/'); 

  try {

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Response data: $data');
    } else {
      print('Failed to load data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}