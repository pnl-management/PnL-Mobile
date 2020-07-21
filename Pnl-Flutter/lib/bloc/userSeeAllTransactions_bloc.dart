import 'dart:async';

import 'package:loginui/resource/get_sharedpref.dart';
import 'package:loginui/resource/user/get_transaction.dart';

class UserSeeAllTransactionsBloc{
  StreamController _userTransations = new StreamController();
  StreamController _periodofTransaction = new StreamController();
  StreamController userInfo = new StreamController();
  Stream get userInfoStream => userInfo.stream;
  Stream get userTransactionsStream =>  _userTransations.stream;
  Stream get periodTransactionsStream =>  _periodofTransaction.stream;
  
  Future<bool> showAllTransaction() async{
    
    
    var user = await GetSharedPref().getUserInfo();
    String token = user.token;
    String name = user.fullName;
    userInfo.sink.add(name);
    var getTransaction = new GetTransactions();
    var result = await getTransaction.seeAllTransaction(token);
    if(result==null){
      _userTransations.sink.addError("There is no transaction to show");
      return false;
    }else{
      _userTransations.sink.add(result);
      _periodofTransaction.sink.add(result[0].period);
      return true;
    }
  }
  void dipose(){
    _userTransations.close();
    _periodofTransaction.close();
  }
}