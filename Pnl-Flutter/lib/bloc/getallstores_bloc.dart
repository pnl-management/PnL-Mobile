import 'dart:async';

import 'package:loginui/models/categoryModel.dart';
import 'package:loginui/models/storeModel.dart';
import 'package:loginui/resource/get_sharedpref.dart';
import 'package:loginui/resource/investor/get_stores.dart';


class GetAllStoresBloc
{
  StreamController getAllStoresStream = StreamController();
  Stream get getAll=> getAllStoresStream.stream;

  List<Store> list = List();
  Future<bool> getAllStores() async {
    var user = await GetSharedPref().getUserInfo();
    String token = user.token;
    var getAllStore = GetStores();
    var result = await getAllStore.getStoresProvider(token);
    print(result.length);
    if(result!=null){
      list.addAll(result);
      getAllStoresStream.sink.add(list);
      return true;
    }else{
      getAllStoresStream.sink.add("Error");
      return false;
    }
  }

  
  void dispose(){
    getAllStoresStream.close();
  }

}