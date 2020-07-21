import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loginui/constant/constant.dart';

class GetEvidences {

  Future<List<String>> getEvidence(String token, int transactionId) async {
    String url = apiUrl + "/api/transactions/" +transactionId.toString() + "/evidences/";
    print(url);
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Authorization": "Bearer " + token});
    List<String> list = List();
    if (response.statusCode == 200) {
      final listData = json.decode(response.body);
      for (var data in listData) {
       String url = data['url'];
       list.add(url);
      }
    }
    return list;
  }
}
