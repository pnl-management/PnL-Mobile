import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loginui/constant/constant.dart';
import 'package:loginui/models/categoryModel.dart';
import 'package:loginui/models/storeModel.dart';

class GetStores {

  Future<List<Store>> getStoresProvider(String token) async {
    String url = apiUrl + "/api/brands/stores";
    
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Authorization": "Bearer " + token});
    List<Store> listStore = List();
    if (response.statusCode == 200) {
      final listData = json.decode(response.body);
      for (var data in listData) {
        int id = data['id'];
        String name = data['name'];
        String phone = data['phone'];
        String address  = data['address'];
        
        Store store = Store(
            id: id,
            name: name,
            phone: phone,
            address: address,);
        listStore.add(store);
      }
    }
    return listStore;
  }
  Future<int> getCatesLength(String token) async {
    String url = apiUrl + "/api/brands/transaction-categories/length";
    
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Authorization": "Bearer " + token});
    if(response.statusCode == 200){
      return int.parse(response.body);
    }
    return null;
  }
}
