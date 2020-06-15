import 'dart:convert';

import 'package:loginui/constant/constant.dart';
import 'package:http/http.dart' as http;
import 'package:loginui/models/transactionModel.dart';

class InvesterTransaction{
  Future<List> getTransactionsForInvestor (String token)async {
  String url = apiUrl + "/api/Transactions/Index";
    var response =
      await http.get(Uri.encodeFull(url), headers: {"Authorization": "Bearer " + token});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List currentPeriod = data;
      List<Transaction> result = new List();
      print("status code 200");
      for(var current in currentPeriod){
        var id = current['id'];
        var name = current['name'];
        var des = current['description'];
        var category =current['category'];
        var type = category['type'];
        print(name);
        Transaction transaction = new Transaction(
          transactionId: id.toString(),
          transactionName: name.toString(),
          transactionDes: des.toString(),
          transactionType: type.toString(),
          money: int.parse(current['value'].toString())
        );
        result.add(transaction);
      }
      
      return result;
    }
  }
}