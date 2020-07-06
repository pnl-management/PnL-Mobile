import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loginui/bloc/getallcategories_bloc.dart';
import 'package:loginui/constant/constant.dart';
import 'package:loginui/models/transactionModel.dart';
import 'package:loginui/models/userModel.dart';
import 'package:loginui/ui/widget/back_button.dart';

class ShowCategories extends StatefulWidget {

  @override
  _ShowCategoriesState createState() => _ShowCategoriesState();
}

class _ShowCategoriesState extends State<ShowCategories> {
  GetAllCategoriesBloc bloc = new GetAllCategoriesBloc();

  int offset;

  @override
  void initState() {
    // TODO: implement initState
    offset = 0;
    bloc.getAllCategories(offset);
    offset = 5;
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
                                "Chọn Loại Giao Dịch",
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
                          print(snapshot.data.length);
                          bloc.getCatesLength(
                             snapshot.data.length);
                          return GestureDetector(
                            onTap: (){
                              
                            },
                            child: Column(
                              children: <Widget>[
                                for (var data in snapshot.data)
                                  PreventCard(
                                    title: data.cateName,
                                  ),
                              ],
                            ),
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
                  StreamBuilder(
                    stream: bloc.getLength,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data == "See") {
                          return GestureDetector(
                            onTap: () {
                              bloc.getAllCategories( offset);
                              offset = 10;
                            },
                            child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 45.0),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.add, color: Colors.grey),
                                      Text(
                                        'XEM THÊM ',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                )),
                          );
                        } else {
                          return Container();
                        }
                      }
                      return Container();
                    },
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
      height: 150,
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
