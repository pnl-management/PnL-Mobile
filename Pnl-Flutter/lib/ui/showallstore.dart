import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loginui/bloc/getallstores_bloc.dart';
import 'package:loginui/constant/constant.dart';
import 'package:loginui/models/transactionModel.dart';
import 'package:loginui/ui/view_store.dart';
import 'package:loginui/ui/widget/back_button.dart';

class ShowStores extends StatefulWidget {
  @override
  _ShowStoresState createState() => _ShowStoresState();
}

class _ShowStoresState extends State<ShowStores> {
  GetAllStoresBloc bloc = new GetAllStoresBloc();

  @override
  void initState() {
    // TODO: implement initState
    bloc.getAllStores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Transaction> data;
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
                        Positioned(
                          top: 60,
                          left: 60,
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Danh sách cửa hàng",
                                style: kHeadingTextStyle.copyWith(
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Container(),
                      ],
                    ))
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: StreamBuilder(
                      stream: bloc.getAll,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          child:
                          return Column(
                            children: <Widget>[
                              for (var data in snapshot.data)
                                GestureDetector(
                                  onTap: () {
                                    int id = data.id;
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => ViewStore(id: id,name:data.name)
                                                ));
                                  },
                                  child: PreventCard(
                                    title: data.name,
                                  ),
                                ),
                            ],
                          );
                        } else {
                          return CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Color(0xFF3383CD)),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PreventCard extends StatelessWidget {
  final String title;
  const PreventCard({
    Key key,
    this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Stack(
        children: <Widget>[
          Container(
            height: 100,
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
            child: Padding(
              padding: const EdgeInsets.only(top: 35, left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: kTitleTextstyle.copyWith(fontSize: 20),
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
