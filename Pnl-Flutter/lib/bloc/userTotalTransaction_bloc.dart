
import 'dart:async';

import 'package:loginui/resource/user/get_transaction.dart';

class UserTotalTransactionBloc{
  StreamController _userTotalTransations = new StreamController();
  StreamController _periodTransaction = new StreamController();
  Stream get userTotalTransactionStream =>  _userTotalTransations.stream;
  Stream get periodTransactionStream =>  _periodTransaction.stream;
  Future<bool> getTotalTransactions(String token) async{
    print("bloc alo");
    var getTransaction = new GetTransactions();
    var result = await getTransaction.getTotal(token);
    if(result==null){
      _userTotalTransations.sink.addError("There is no transaction to show");
      return false;
    }else{
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