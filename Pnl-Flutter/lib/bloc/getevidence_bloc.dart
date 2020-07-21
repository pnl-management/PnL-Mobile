import 'dart:async';

import 'package:loginui/models/categoryModel.dart';
import 'package:loginui/resource/get_sharedpref.dart';
import 'package:loginui/resource/investor/get_evidences.dart';
import 'package:loginui/resource/user/get_categories.dart';

class GetEvidenceBloc{
  StreamController getEvidenceStream = StreamController();
  Stream get getUrls=> getEvidenceStream.stream;

  List<String> list = List();
  Future<bool> getAllEvidences(int transactionId) async {
    var user = await GetSharedPref().getUserInfo();
    String token = user.token;
    var getAllEvidence = GetEvidences();
    var result = await getAllEvidence.getEvidence(token, transactionId);
    print(result.length);
    print(list.length);
    if(result!=null){
      list.addAll(result);
      getEvidenceStream.sink.add(list);
      return true;
    }else{
      getEvidenceStream.sink.add("Error");
      return false;
    }
  }
  void dispose(){
    getEvidenceStream.close();
  }

}