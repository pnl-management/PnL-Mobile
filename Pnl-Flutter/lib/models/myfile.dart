import 'dart:convert';
import 'dart:io';

import 'package:loginui/models/transactionModel.dart';

class MyFile{
  String fileName;
  String extension;
  File file;
  bool isDelete;
  String url; 
  bool isNew;
  Transaction transaction;
  MyFile({this.extension,this.file,this.fileName, this.isDelete, this.url, this.isNew,this.transaction});
  Map toJson()=>{
    'url' : url,
    'transaction' : {'id' : transaction.transactionId}
  };
}