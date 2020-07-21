import 'dart:async';

import 'package:loginui/resource/get_sharedpref.dart';

import 'package:loginui/resource/investor/get_store_detail.dart';

class GetStoreDetailBloc {
  StreamController getStoreDetailStream = StreamController();
  Stream get getDetail => getStoreDetailStream.stream;

  Future<bool> getStoreDetail(int id) async {
    var user = await GetSharedPref().getUserInfo();
    String token = user.token;
    var getStoreDetail = GetStoreDetail();
    var result = await getStoreDetail.getStoreDetailProvider(token, id);
    if (result != null) {
      getStoreDetailStream.sink.add(result);
      return true;
    } else {
      getStoreDetailStream.sink.add("Error");
      return false;
    }
  }

  void dispose() {
    getStoreDetailStream.close();
  }
}
