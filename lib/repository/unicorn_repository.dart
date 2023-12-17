import 'package:crudapiproject/data/api_client.dart';
import 'package:crudapiproject/data/models/uicornsmodel.dart';

class UnicornRepos {
  final _apiClient = ApiClient();

  Future<UnicornModel> adddata(Map<String, dynamic> body) async {
    final postresponse = await _apiClient.addPost(body: body);
    return UnicornModel.fromJson(postresponse);
  }

  Future<List<UnicornModel>> getdata() async {
    List<UnicornModel> unicorns = [];
    final postresponse = await _apiClient.getPosts();
    for (var e in postresponse) {
      unicorns.add(UnicornModel.fromJson(e));
    }
    return unicorns;
  }

  Future<UnicornModel> updatePost(Map<String, dynamic> body) async {
    final postresponse = await _apiClient.updatePost(body: body);
    return UnicornModel.fromJson(postresponse);
  }

  Future<UnicornModel> deletePost() async {
    final postresponse = await _apiClient.deletePost();
    return UnicornModel.fromJson(postresponse);
  }
}
