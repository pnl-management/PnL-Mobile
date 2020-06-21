import 'dart:async';

import 'package:loginui/resource/user/get_transaction.dart';

class UserSeeAllTransactionsBloc{
  StreamController _userTransations = new StreamController();
  StreamController _periodofTransaction = new StreamController();
  Stream get userTransactionsStream =>  _userTransations.stream;
  Stream get periodTransactionsStream =>  _periodofTransaction.stream;
  
  Future<bool> showAllTransaction(String token) async{
    print("bloc alo");
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