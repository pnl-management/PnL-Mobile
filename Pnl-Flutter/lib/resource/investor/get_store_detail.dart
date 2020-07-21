import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loginui/constant/constant.dart';
import 'package:loginui/models/storeModel.dart';

class GetStoreDetail {
  Future<Store> getStoreDetailProvider(String token, int id) async {
    String url = apiUrl + "/api/stores/" + id.toString();
    
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Authorization": "Bearer " + token});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      int id = data['id'];
      String name = data['name'];
      String phone = data['phone'];
      String address = data['address'];

      Store store = Store(
        id: id,
        name: name,
        phone: phone,
        address: address,
      );
      return store;
    }
    return null;
  }

}
