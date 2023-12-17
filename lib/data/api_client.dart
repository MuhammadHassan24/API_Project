import 'dart:convert';

import 'package:crudapiproject/data/models/uicornsmodel.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  String baseurl = "crudcrud.com/api/ce8eb75f7a04466a91b13822c6bee563/unicorns";
  // String endurl = "";

  Future<dynamic> addPost({
    required Map<String, dynamic> body,
  }) async {
    var url = Uri.parse(baseurl);
    var response = await http.post(
      url,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 201) {
      print(response);
      if (response.headers['content-type']?.contains('application/json') ??
          false) {
        try {
          return UnicornModel.fromJson(jsonDecode(response.body));
        } catch (e) {
          print('Error decoding JSON: $e');
          throw Exception('Failed to create data');
        }
      } else {
        throw Exception('Failed to create data: Non-JSON response');
      }
    } else {
      throw Exception('Failed to create data');
    }
  }

  Future getPosts() async {
    var url = Uri.parse(baseurl);
    var response = await http.get(url);
    if (response.statusCode >= 200 || response.statusCode < 300) {
      return jsonDecode(response.body);
    }
  }

  Future updatePost({
    required Map<String, dynamic> body,
  }) async {
    var url = Uri.parse(baseurl);
    var response = await http.put(
      url,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode >= 200 || response.statusCode < 300) {
      return jsonDecode(response.body);
    }
  }

  Future deletePost() async {
    var url = Uri.parse(baseurl);
    var response = await http.delete(url, headers: {
      'Content-Type': 'application/json',
    });
    if (response.body.isNotEmpty) {
      return json.decode(response.body);
    }
  }
}
