import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:loginui/models/categoryModel.dart';
import 'package:loginui/models/myfile.dart';
import 'package:loginui/models/transactionModel.dart';
import 'package:loginui/resource/get_sharedpref.dart';
import 'package:loginui/resource/user/create_transaction.dart';


class CreateTransactionBloc {
  StreamController createStream = StreamController();
  Stream get createGet => createStream.stream;

  Future<bool> createTransaction(
      Transaction transaction, Category category, List<MyFile> listImg) async {
    StorageReference storageReference;
    StorageUploadTask uploadTask;
    var user = await GetSharedPref().getUserInfo();
    String token = user.token;
    var createTransaction = CreateTransactionsProvider();
    var check = await createTransaction.createTransactions(token, transaction, category);
    transaction.transactionId = check.toString();
    print(check);
    if (check != null) {
      for (var img in listImg) {
        if (!img.isDelete && img.isNew) {
          var filename =
              img.file.path.substring(img.file.path.lastIndexOf('/') + 1);
          storageReference =
              FirebaseStorage.instance.ref().child('Evidences/' + filename);
          uploadTask = storageReference.putFile(img.file);
          await uploadTask.onComplete;
          await storageReference.getDownloadURL().then((value) {
            print(value);
            img.url = value;
            img.transaction = transaction;
          });
        }
      }
      var result = await createTransaction.createEvidences(
        token, transaction.transactionId, listImg);
        print(result);
        if(result){
          return true;
        }
    }
    return false;
  }

  void dispose() {
    createStream.close();
  }
}
