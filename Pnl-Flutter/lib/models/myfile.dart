import 'dart:io';

class MyFile{
  String fileName;
  String extension;
  File file;
  bool isDelete;
  String url; 
  bool isNew;
  MyFile({this.extension,this.file,this.fileName, this.isDelete, this.url, this.isNew});
}