import '../models/item_model.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'dart:async';
import 'repository.dart';

final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  Client client = Client();
  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$_root/topstories.json');
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    print("About to send Api Call ");
    final response = await client.get('$_root/item/$id.json');
    final parsedJson = json.decode(response.body);
    print("Hello I have sent the Api call");
    return ItemModel.fromJson(parsedJson);
  }
}
