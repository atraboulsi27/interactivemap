import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:interactivemap/Model/StoryClass.dart';

class StoryRepo{
  getStories() async {
    final response = await http.get(
      Uri.parse('http://dwp.world/wp-json/wp/v2/stories'),
    );

    List<Story> stories = [];
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data.forEach((e)  {
        stories.add(Story.fromJson(e));

      });
      return stories;
    } else {
      print(response.statusCode);
      return false;
    }
  }
}