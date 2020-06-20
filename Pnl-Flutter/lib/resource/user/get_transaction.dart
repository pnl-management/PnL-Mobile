

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loginui/constant/constant.dart';
import 'package:loginui/models/transactionModel.dart';

class GetTransactions{
    Future<List<String>> getTotal (String token)async {
    String url = apiUrl + "/api/Transactions/Index";
    print(url);
    var response =
      await http.get(Uri.encodeFull(url), headers: {"Authorization": "Bearer " + token});
    if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List currentPeriod = data['currentPeriod'];
        int totalRevenue = 0;
        int totalExpense = 0;
        var period = currentPeriod[0]['period'];
        var periodDetails = period['title'];
        for(var current in currentPeriod){
          var category = current['category'];
          var type = category['type'].toString();
          
          if(type == revenue){
            totalRevenue += int.parse(current['value']);
          }else{
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
   Future<List<Transaction>> seeAllTransaction (String token)async {
    String url = apiUrl + "/api/Transactions/Index";
    print(url);
    var response =
      await http.get(Uri.encodeFull(url), headers: {"Authorization": "Bearer " + token});
    if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List currentPeriod = data['currentPeriod'];
        var period = currentPeriod[0]['period'];
        var periodDetails = period['title'];
        for(var current in currentPeriod){
          var category = current['category'];
          var type = category['type'].toString(); 
        }
        List<Transaction> list = new List();

        return list;
      }
   }
}