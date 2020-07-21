import 'dart:async';

import 'package:loginui/models/transactionModel.dart';
import 'package:loginui/resource/get_sharedpref.dart';
import 'package:loginui/resource/investor/investor_transaction.dart';
class InvestorHomePageBloc{
  StreamController _investorTransations = new StreamController();
  StreamController _periodTransaction = new StreamController();
  StreamController investorInfo = new StreamController();
  Stream get investorInfoStream => investorInfo.stream;
  Stream get userTotalTransactionStream =>  _investorTransations.stream;
  Stream get periodTransactionStream =>  _periodTransaction.stream;

  Future<bool> getTotalTransactions() async{
    print("bloc alo");
    var user = await GetSharedPref().getUserInfo();
    String name = user.fullName;
    String token = user.token;
    var investor_transaction = InvesterTransaction();
    var result = await investor_transaction.getTransactionsForInvestor(token);
    investorInfo.sink.add(name);
    if(result==null){
      _investorTransations.sink.addError("There is no transaction to show");
      return false;
    }else{
      print(result[0].period);
      _investorTransations.sink.add(result);
      _periodTransaction.sink.add(result[0].period);
      return true;
    }
  }

  void dispose(){
    _investorTransations.close();
    _periodTransaction.close();
  }
}