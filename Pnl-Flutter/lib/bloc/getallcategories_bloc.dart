import 'dart:async';

import 'package:loginui/models/categoryModel.dart';
import 'package:loginui/resource/get_sharedpref.dart';
import 'package:loginui/resource/user/get_categories.dart';

class GetAllCategoriesBloc{
  StreamController getAllCategoriesStream = StreamController();
  StreamController getCatesLengthStream = StreamController();
  Stream get getLength => getCatesLengthStream.stream;
  Stream get getAll=> getAllCategoriesStream.stream;

  List<Category> list = List();
  Future<bool> getAllCategories(offset) async {
    var user = await GetSharedPref().getUserInfo();
    String token = user.token;
    var getAllCategory = GetCategories();
    var result = await getAllCategory.getCates(token,offset);
    
    if(result!=null){
      list.addAll(result);
      getAllCategoriesStream.sink.add(list);
      return true;
    }else{
      getAllCategoriesStream.sink.add("Error");
      return false;
    }
  }

  Future<bool> getCatesLength( int length) async {
    var user = await GetSharedPref().getUserInfo();
    String token = user.token;
    var getAllCategory = GetCategories();
    var result = await getAllCategory.getCatesLength(token);
    if(result > length){
      getCatesLengthStream.sink.add("See");
      return true;
    }else{
      getCatesLengthStream.sink.add("OK");
      return false;
    }
  }
  void dispose(){
    getAllCategoriesStream.close();
    getCatesLengthStream.close();
  }

}