import 'dart:convert';

import 'package:http/http.dart' as http;

String Token = "";

class User {
  Login(String email, String pass) async {
    final response = await http.post(
      Uri.parse('http://dwp.world/wp-json/jwt-auth/v1/token'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'username': email, 'password': pass}),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Token = data["token"];
      print(Token);
      return true;
    } else {
      return false;
    }
  }
}
