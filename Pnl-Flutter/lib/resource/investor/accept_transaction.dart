import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loginui/constant/constant.dart';

class AcceptTransactionProvider {
  Future<bool> acceptTransaction(
      String token, int transactionId, String feedback, String type) async {
    String url = apiUrl +
        "/api/transactions/" +
        transactionId.toString() +
        "/journeys?type=" +
        type;
    
    var transaction = { 'id' : transactionId};
    var body = json.encode({
      'feedback': feedback,
      'Transaction' : transaction
    });
    var response = await http.post(Uri.encodeFull(url),
        headers: {"Authorization": "Bearer " + token,"Content-Type": "application/json"}, body: body);
       
    if (response.statusCode == 201) {
      return true;
    }else{
      return false;
    }
  }
}
