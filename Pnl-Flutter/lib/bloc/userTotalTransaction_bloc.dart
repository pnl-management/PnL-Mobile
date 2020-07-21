
import 'dart:async';

import 'package:loginui/resource/get_sharedpref.dart';
import 'package:loginui/resource/user/get_transaction.dart';

class UserTotalTransactionBloc{
  StreamController _userTotalTransations = new StreamController();
  StreamController _periodTransaction = new StreamController();
  StreamController userInfoStream = new StreamController();
  Stream get userTotalTransactionStream =>  _userTotalTransations.stream;
  Stream get periodTransactionStream =>  _periodTransaction.stream;
  Stream get userInfo=> userInfoStream.stream;

  Future<bool> getTotalTransactions() async{
    var user = await GetSharedPref().getUserInfo();
    String token = user.token;
    String brandName =  user.brandName;
    String storeName = user.storeName;
    
    var getTransaction = new GetTransactions();
    var result = await getTransaction.getTotal(token);
    if(result==null){
      userInfoStream.sink.add(user);
      _userTotalTransations.sink.addError("There is no transaction to show");
      return false;
    }else{
      userInfoStream.sink.add(brandName + "-" + storeName);
      _userTotalTransations.sink.add(result);
      _periodTransaction.sink.add(result[2]);
      return true;
    }
  }

  
  void dispose(){
    _userTotalTransations.close();
    _periodTransaction.close();
  }
}