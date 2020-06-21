import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loginui/bloc/userSeeAllTransactions_bloc.dart';
import 'package:loginui/constant/constant.dart';
import 'package:loginui/models/transactionModel.dart';
import 'package:loginui/models/userModel.dart';

class UserTransactionDetails extends StatelessWidget {
  UserTransactionDetails(this.user);
  final User user;
  UserSeeAllTransactionsBloc bloc = new UserSeeAllTransactionsBloc();

  @override
  Widget build(BuildContext context) {
    bloc.showAllTransaction(user.token);
    List<Transaction> data;
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
                    Align(
                        alignment: Alignment.topRight,
                        child: SvgPicture.asset("assets/icons/menu.svg")),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: StreamBuilder(
                          stream: bloc.periodTransactionsStream,
                          builder: (context, snapshot) => Stack(
                                children: <Widget>[
                                  // SvgPicture.asset("assets/icons/investor.svg",
                                  // width: 200,
                                  // fit: BoxFit.fitWidth,
                                  // alignment: Alignment.topCenter,
                                  // ),
                                  Positioned(
                                    top: 80,
                                    left: 10,
                                    child: Text(
                                      "Tất Cả Giao Dịch Trong " + snapshot.data,
                                      style: kHeadingTextStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                  ),
                                  Container(),
                                ],
                              )),
                    )
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
                            stream: bloc.userTransactionsStream,
                            builder: (context, snapshot) => Column(
                                  children: <Widget>[
                                    for (var data in snapshot.data)
                                      PreventCard(
                                        title: data.transactionName,
                                        content: data.transactionDes,
                                        money: data.money,
                                        type: int.parse(
                                            data.transactionType.toString()),
                                      ),
                                  ],
                                )))
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
  final String content;
  final int money;
  final int type;
  const PreventCard({
    Key key,
    this.title,
    this.content,
    this.money,
    this.type,
  }) : super(key: key);
  Color getColor(int type) {
    print("Type " + type.toString());
    if (type.toString() == revenue) {
      print("return " + kRecovercolor.toString());
      return kRecovercolor;
    }
    if (type.toString() == expense) {
      print("return " + kDeathColor.toString());
      return kDeathColor;
    }
  }

  String formatMoney(String amount) {
    print(amount);
    if (amount.contains("-")) {
      print("negative");
      String money = amount.split("-")[1];
      MoneyFormatterOutput fo =
          FlutterMoneyFormatter(amount: double.parse(money)).output;
      return "-" + fo.compactNonSymbol;
    } else {
      print("positive");
      MoneyFormatterOutput fo =
          FlutterMoneyFormatter(amount: double.parse(amount)).output;
      print(fo.compactNonSymbol);
      return fo.compactNonSymbol;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Stack(
        children: <Widget>[
          Container(
            height: 136,
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
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              height: 150,
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
                    style: TextStyle(fontSize: 12),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      formatMoney(money.toString()),
                      style: TextStyle(fontSize: 20, color: getColor(type)),
                    ),
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
