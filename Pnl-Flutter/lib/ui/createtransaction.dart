
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginui/bloc/createtransaction_bloc.dart';
import 'package:loginui/constant/constant.dart';
import 'package:loginui/models/categoryModel.dart';
import 'package:loginui/models/myfile.dart';
import 'package:loginui/models/transactionModel.dart';
import 'package:loginui/ui/widget/back_button.dart';
import 'package:loginui/ui/widget/text_file.dart';

class CreateTransaction extends StatefulWidget {
  final int cateId;
  final String cateName;
  CreateTransaction({Key key, this.cateId, this.cateName}) : super(key: key);
  @override
  _CreateTransactionState createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  TextEditingController moneyController = TextEditingController();
  CreateTransactionBloc bloc = CreateTransactionBloc();
  TextEditingController desController = TextEditingController();
  List<MyFile> listImg;

  @override
  void initState() {
    listImg = List();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                padding: EdgeInsets.only(left: 20, top: 50, right: 20),
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xFF3383CD), Color(0xFF11249F)]),
                  image: DecorationImage(
                    image: AssetImage("assets/images/virus.png"),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(alignment: Alignment.topLeft, child: MyBackButton()),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: Stack(
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icons/phone.svg",
                          width: 150,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                        Positioned(
                          top: 20,
                          left: 150,
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Tạo Hoá Đơn",
                                style: kHeadingTextStyle.copyWith(
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.cateName,
                                style:
                                    kSubTextStyle.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Container(),
                      ],
                    )),
                  ],
                ),
              ),
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      label: "Tên Hoá Đơn",
                      controller: nameController,
                      validator: (value) {
                        if (nameController.text.trim().isEmpty) {
                          return "Name cannot be empty";
                        }
                        return null;
                      },
                    ),
                    MyTextField(
                      label: "Số Tiền",
                      controller: moneyController,
                      keyboard: TextInputType.number,
                      validator: (value) {
                        if (moneyController.text.trim().isEmpty) {
                          return "Money cannot be empty";
                        }
                        return null;
                      },
                    ),
                    MyTextField(
                      label: "Mô Tả",
                      controller: desController,
                      validator: (value) {
                        if (desController.text.trim().isEmpty) {
                          return "Description cannot be empty";
                        }
                        return null;
                      },
                    ),
                    Text('Chứng Từ',
                        style: kHeadingTextStyle.copyWith(color: Colors.blue[800])),
                    _buildListImg(),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (formKey.currentState.validate()) {
                              Transaction transaction = Transaction();
                              transaction.transactionName = nameController.text;
                              transaction.money =
                                  int.parse(moneyController.text);
                              transaction.transactionDes = desController.text;
                              Category category = Category();
                              category.cateId =
                                  int.parse(widget.cateId.toString());
                              if (listImg.length >= 1) {}
                              showDialogConfirmActive();
                              bloc
                                  .createTransaction(
                                      transaction, category, listImg)
                                  .then((value) {
                                Navigator.of(context).pop();
                              });
                            }
                          },
                          child: Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 10.0, top: 10.0),
                              child: new Container(
                                alignment: Alignment.center,
                                height: 60.0,
                                width: width - 80,
                                decoration: new BoxDecoration(
                                  color: kRecovercolor,
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: new Text("Tạo Hoá Đơn ",
                                    style: new TextStyle(
                                        fontSize: 20.0, color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDialogConfirmActive() {
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Processing"),
          content: Container(
            height: 80,
            child: Center(
              child: Column(children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Please Wait....",
                  style: TextStyle(color: Colors.blueAccent),
                )
              ]),
            ),
          ),
        );
      },
    );
  }

  _buildListImg() {
    if (listImg == null)
      return Container(
        height: 0,
        width: 0,
      );

    return Container(
      child: Column(
        children: [
          (() {
            var listWidget = <Widget>[];
            for (var img in listImg) {
              print(img.url);
              listWidget.add(_buildEachImg(img));
            }
            return Column(
              children: listWidget,
            );
          }()),
          Container(
            child: Center(
              child: ButtonTheme(
                buttonColor: Color(0xFF3383CD),
                child: RaisedButton(
                  child: Text(
                    "Thêm hình ảnh",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    ImagePicker.pickImage(source: ImageSource.gallery)
                        .then((img) {
                      MyFile fileImg = MyFile();

                      fileImg.file = img;
                      fileImg.url = img.path;
                      fileImg.isDelete = false;
                      fileImg.isNew = true;

                      this.setState(() {
                        listImg.add(fileImg);
                      });
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildEachImg(MyFile img) {
    if (img.isDelete)
      return Container(
        width: 0,
        height: 0,
      );
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Center(
            child: Container(
              width: 230,
              height: 230,
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                //border: Border.all(width: 1, color: Color(0xFF00C853)),
                image: new DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: img.file == null
                      ? new NetworkImage(img.url)
                      : FileImage(img.file),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              
              this.setState(() {
                if (img.isNew) {
                  listImg.removeAt(listImg.indexOf(img));
                } else {
                  img.isDelete = true;
                }
              });
            },
            child: Icon(
              Icons.close,
              color: Color(0xFFF44336),
            ),
          ),
        ),
      ],
    );
  }
}

class PreventCard extends StatelessWidget {
  final String title;
  final String content;
  final double height;
  const PreventCard({
    Key key,
    this.title,
    this.content,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        children: <Widget>[
          Container(
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 8),
                  blurRadius: 24,
                  color: kShadowColor,
                )
              ],
            ),
          ),
          Positioned(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: height,
              width: MediaQuery.of(context).size.width - 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: kTitleTextstyle.copyWith(fontSize: 16),
                  ),
                  Text(
                    content,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
