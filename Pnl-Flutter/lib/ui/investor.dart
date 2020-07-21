import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loginui/bloc/investorHomePage_bloc.dart';
import 'package:loginui/constant/constant.dart';
import 'package:loginui/models/transactionModel.dart';
import 'package:loginui/ui/accept_transaction.dart';

class InvestorPage extends StatefulWidget {
  @override
  _InvestorPageState createState() => _InvestorPageState();
}

class _InvestorPageState extends State<InvestorPage> {
  InvestorHomePageBloc bloc = new InvestorHomePageBloc();

  @override
  void initState() {
    bloc.getTotalTransactions();
    // TODO: implement initState
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
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: Stack(
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icons/investor.svg",
                          width: 200,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                        StreamBuilder(
                            stream: bloc.investorInfoStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Positioned(
                                  top: 20,
                                  left: 180,
                                  child: Container(
                                    width: 150,
                                    child: Text(
                                              "Xin Chào \nÔng " +
                                          snapshot.data,
                                      style: kHeadingTextStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }),
                        Container(),
                      ],
                    )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: StreamBuilder(
                stream: bloc.periodTransactionStream,
                builder: (context, snapshot) => Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Tất Cả Giao Dịch Gần Nhất\n",
                                style: kTitleTextstyle,
                              ),
                              TextSpan(
                                  text: snapshot.data,
                                  style: TextStyle(
                                    color: kTextLightColor,
                                  )),
                            ],
                          ),
                        ),
                        Spacer(),
                        // Text(
                        //   "Xem thêm",
                        //   style: TextStyle(
                        //     color: kPrimaryColor,
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        child: StreamBuilder(
                            stream: bloc.userTotalTransactionStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var listWidget = <Widget>[];
                                for (var data in snapshot.data) {
                                  listWidget.add(PreventCard(
                                    title: "Mã giao dịch " +
                                        data.transactionId +
                                        " : " +
                                        data.transactionName,
                                    content: "Ngày Tạo :" +
                                        data.createdTime +
                                        ".\nMô tả : " +
                                        data.transactionDes,
                                    money: data.money,
                                    type: int.parse(
                                        data.transactionType.toString()),
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  AcceptTransaction(
                                                    transaction: data,
                                                  )))
                                          .then((value) =>
                                              bloc.getTotalTransactions());
                                    },
                                  ));
                                }
                                return Column(
                                  children: listWidget,
                                );
                              } else {
                                return CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Color(0xFF3383CD)),
                                );
                              }
                            }))
                  ],
                ),
              ),
            )
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
  final Function onTap;
  const PreventCard({
    Key key,
    this.title,
    this.content,
    this.money,
    this.type,
    this.onTap,
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
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 120,
        child: Stack(
          children: <Widget>[
            Container(
              height: 110,
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
                height: 120,
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
                      style: TextStyle(fontSize: 14),
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
