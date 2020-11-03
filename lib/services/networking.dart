import 'package:http/http.dart' as http;
import 'dart:convert';

class Network{
  Network(this.url);

  final String url;

  Future getData() async{
    http.Response response = await http.get(url);

    String data = response.body;

    return jsonDecode(data);
  }
}