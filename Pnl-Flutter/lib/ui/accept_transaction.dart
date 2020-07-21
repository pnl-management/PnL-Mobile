import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loginui/bloc/accepttransaction.dart';
import 'package:loginui/bloc/getevidence_bloc.dart';
import 'package:loginui/constant/constant.dart';
import 'package:loginui/models/transactionModel.dart';
import 'package:loginui/ui/widget/back_button.dart';
import 'package:loginui/ui/widget/text_file.dart';

void main() {
  runApp(AcceptTransaction());
}

class AcceptTransaction extends StatefulWidget {
  final Transaction transaction;

  const AcceptTransaction({Key key, this.transaction}) : super(key: key);

  @override
  _AcceptTransactionState createState() => _AcceptTransactionState();
}

class _AcceptTransactionState extends State<AcceptTransaction> {
  GetEvidenceBloc bloc = GetEvidenceBloc();
  AcceptTransactionBloc acceptBloc = AcceptTransactionBloc();
  TextEditingController feedbackController = TextEditingController();
  @override
  void initState() {
    bloc.getAllEvidences(int.parse(widget.transaction.transactionId));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                padding: EdgeInsets.only(left: 40, top: 50, right: 20),
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
                          width: 200,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                        Positioned(
                          top: 20,
                          left: 200,
                          child: Text(
                            "Chi Tiết \nGiao Dịch",
                            style:
                                kHeadingTextStyle.copyWith(color: Colors.white),
                          ),
                        ),
                        Container(),
                      ],
                    )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Mã Hoá Đơn\n",
                              style: kTitleTextstyle,
                            ),
                            TextSpan(
                                text: "#" + widget.transaction.transactionId,
                                style: TextStyle(
                                  color: kTextLightColor,
                                )),
                          ],
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // PreventCard(
                  //   title: "Trạng Thái",
                  //   content: "",
                  //   height: 100,
                  // ),
                  PreventCard(
                    title: "Loại giao dịch",
                    content: widget.transaction.transactionType == revenue ? "Doanh thu" : "Chi Phí",
                    height: 100,
                  ),
                  PreventCard(
                    title: "Tên giao dịch",
                    content: widget.transaction.transactionName,
                    height: 100,
                  ),
                  PreventCard(
                    title: "Ngày Tạo",
                    content: "28/03/2020",
                    height: 100,
                  ),
                  PreventCard(
                    title: "Số Tiền",
                    content: widget.transaction.money.toString(),
                    height: 100,
                  ),
                  PreventCard(
                    title: "Mô Tả",
                    content: widget.transaction.transactionDes,
                    height: 100,
                  ),
                  SizedBox(
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width - 50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                
                                SizedBox(height: 10),
                                MyTextField(
                                    label: "Feedback",
                                    controller: feedbackController)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 10.0, top: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              String feedback = feedbackController.text;
                              showDialogConfirmActive();
                              acceptBloc.AcceptTransaction(
                                  int.parse(widget.transaction.transactionId),
                                  feedback,
                                  "reject").then((value) => Navigator.of(context).pop());
                            },
                            child: new Container(
                              alignment: Alignment.center,
                              height: 60.0,
                              decoration: new BoxDecoration(
                                color: Color(0xFFDF513B),
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                              child: new Text("Từ Chối",
                                  style: new TextStyle(
                                      fontSize: 20.0, color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 10.0, top: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              String feedback = feedbackController.text;
                              showDialogConfirmActive();
                              acceptBloc.AcceptTransaction(
                                  int.parse(widget.transaction.transactionId),
                                  feedback,
                                  "req-modified").then((value) => Navigator.of(context).pop());
                            },
                            child: new Container(
                              alignment: Alignment.center,
                              height: 60.0,
                              decoration: new BoxDecoration(
                                color: kInfectedColor,
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                              child: new Text("Yêu Cầu Sửa",
                                  style: new TextStyle(
                                      fontSize: 20.0, color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 10.0, top: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        String feedback = feedbackController.text;
                        showDialogConfirmActive();
                        acceptBloc.AcceptTransaction(
                            int.parse(widget.transaction.transactionId),
                            feedback,
                            "approve").then((value) => Navigator.of(context).pop());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(
                          color: kRecovercolor,
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        child: new Text("Chấp Nhận",
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.white)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
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

  buildImage(String url) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Container(
            width: 230,
            height: 230,
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(width: 1, color: Color(0xFF00C853)),
              image: new DecorationImage(
                  fit: BoxFit.fitWidth, image: NetworkImage(url)),
            ),
          ),
        ),
      ),
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
                  SizedBox(height: 20),
                  Text(
                    title,
                    style: kTitleTextstyle.copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 10),
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
