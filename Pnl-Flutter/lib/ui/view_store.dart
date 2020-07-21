import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loginui/bloc/getstoredetail_bloc.dart';
import 'package:loginui/constant/constant.dart';
import 'package:loginui/models/transactionModel.dart';
import 'package:loginui/ui/widget/back_button.dart';
import 'package:loginui/ui/widget/text_file.dart';

class ViewStore extends StatefulWidget {
  final int id;
  final String name;

  const ViewStore({Key key, this.id, this.name}) : super(key: key);

  @override
  _ViewStoreState createState() => _ViewStoreState();
}

class _ViewStoreState extends State<ViewStore> {
  GetStoreDetailBloc bloc = GetStoreDetailBloc();
  @override
  void initState() {
    bloc.getStoreDetail(widget.id);
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
                            widget.name,
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
            StreamBuilder(
                stream: bloc.getDetail,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Mã Cửa Hàng\n",
                                      style: kTitleTextstyle,
                                    ),
                                    TextSpan(
                                        text: "#" + widget.id.toString(),
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
                          PreventCard(
                            title: "Tên Cửa Hàng",
                            content: snapshot.data.name,
                            height: 100,
                          ),
                          PreventCard(
                            title: "Số Điện Thoại",
                            content: snapshot.data.phone,
                            height: 100,
                          ),
                          PreventCard(
                            title: "Địa Chỉ",
                            content: snapshot.data.address,
                            height: 100,
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
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
