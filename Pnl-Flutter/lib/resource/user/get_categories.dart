import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loginui/constant/constant.dart';
import 'package:loginui/models/categoryModel.dart';

class GetCategories {

  Future<List<Category>> getCates(String token, int offset) async {
    String url = apiUrl + "/api/brands/transaction-categories?offset="+offset.toString();
    
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Authorization": "Bearer " + token});
    List<Category> listCate = List();
    if (response.statusCode == 200) {
      final listData = json.decode(response.body);
      for (var data in listData) {
        int id = data['id'];
        String name = data['name'];
        int type = data['type'];
        bool required = data['required'];
        bool status = data['status'];
        Category category = Category(
            cateId: id,
            cateName: name,
            type: type,
            required: required,
            status: status);
        listCate.add(category);
      }
    }
    return listCate;
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
