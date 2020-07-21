import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loginui/constant/constant.dart';
import 'package:loginui/models/transactionModel.dart';

class GetTransactions {
  Future<List<String>> getTotal(String token) async {
    String url = apiUrl + "/api/Transactions/Index";
    print(url);
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Authorization": "Bearer " + token});
    List<String> list = new List();
    int totalRevenue = 0;
    int totalExpense = 0;
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List currentPeriod = data['currentPeriod'];
      if (currentPeriod == null) {
        list.add(totalRevenue.toString());
        list.add(totalExpense.toString());
        return list;
      } else {
        var period = currentPeriod[0]['period'];
        var periodDetails = period['title'];
        for (var current in currentPeriod) {
          var category = current['category'];
          var type = category['type'].toString();
          if (type == revenue) {
            totalRevenue += int.parse(current['value']);
          } else {
            totalExpense += int.parse(current['value']);
          }
        }
        List<String> list = new List();
        list.add(totalExpense.toString());
        list.add(totalRevenue.toString());
        list.add(periodDetails);
        return list;
      }
    }
  }

  Future<List<Transaction>> seeAllTransaction(String token) async {
    String url = apiUrl + "/api/Transactions/Index";
    print(url);
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Authorization": "Bearer " + token});
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List currentPeriod = data['currentPeriod'];
      var period = currentPeriod[0]['period'];
      var periodDetails = period['title'];
      List<Transaction> list = new List();
      for (var current in currentPeriod) {
        var category = current['category'];
        var type = category['type'].toString();
        var id = current['id'].toString();
        var name = current['name'].toString();
        var des = current['description'].toString();
        var value = current['value'].toString();
        Transaction transaction = Transaction(
            transactionId: id,
            transactionName: name,
            transactionDes: des,
            transactionType: type,
            period: periodDetails,
            money: int.parse(value));
        list.add(transaction);
      }
      return list;
    }
  }
}
