import 'dart:async';
import 'package:loginui/resource/get_sharedpref.dart';
import 'package:loginui/resource/investor/accept_transaction.dart';



class AcceptTransactionBloc {
  StreamController acceptStream = StreamController();
  Stream get acceptGet => acceptStream.stream;

  Future<bool> AcceptTransaction(
      int transactionId, String feedback, String type) async {
    var user = await GetSharedPref().getUserInfo();
    String token = user.token;
    var acceptTransaction = AcceptTransactionProvider();
    var check = await acceptTransaction.acceptTransaction(token, transactionId, feedback, type);
    if(check){
      return true;
    }else{
      return false;
    }
  }

  void dispose() {
    acceptStream.close();
  }
}
