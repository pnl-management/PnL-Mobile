import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loginui/constant/constant.dart';
import 'package:loginui/models/categoryModel.dart';
import 'package:loginui/models/myfile.dart';
import 'package:loginui/models/transactionModel.dart';

class CreateTransactionsProvider {
  Future<int> createTransactions(
      String token, Transaction transaction, Category category) async {
    String url = apiUrl + "/api/receipts";

    var categoryBody = {
      'id': category.cateId,
    };
    var transactionBody = json.encode({
      'name': transaction.transactionName,
      'value': transaction.money,
      'description': transaction.transactionDes,
      'category': categoryBody
    });

    var response = await http.post(Uri.encodeFull(url),
        headers: {
          "Authorization": "Bearer " + token,
          "Content-Type": "application/json"
        },
        body: transactionBody);

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      int transactionId = data['id'];

      return transactionId;
    }
    return null;
  }

  Future<bool> createEvidences(
      String token, String transactionId, List<MyFile> imageUrl) async {
    String url = apiUrl + "/api/receipts/" + transactionId + "/evidences";

    var body = jsonEncode(imageUrl);

    var response = await http.post(Uri.encodeFull(url),
        headers: {
          "Authorization": "Bearer " + token,
          "Content-Type": "application/json"
        },
        body: body);
    if (response.statusCode == 201) {
      return true;
    }
    return null;
  }
}
