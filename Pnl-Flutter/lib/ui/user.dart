import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loginui/bloc/userTotalTransaction_bloc.dart';
import 'package:loginui/constant/constant.dart';
import 'package:loginui/models/userModel.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:loginui/ui/showallcategories.dart';
import 'package:loginui/ui/userseemore.dart';

class UserHomeScreen extends StatefulWidget {
  
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  UserTotalTransactionBloc bloc = new UserTotalTransactionBloc();

  @override
  void initState() {
    // TODO: implement initState
     bloc.getTotalTransactions();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      body: Column(
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
                  //MyBackButton(),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: Stack(
                    children: <Widget>[
                      SvgPicture.asset(
                        "assets/icons/shop.svg",
                        width: 150,
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                      ),
                      StreamBuilder<Object>(
                        stream: bloc.userInfo,
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            return Positioned(
                            top: 20,
                            left: 180,
                            child: Text(
                              snapshot.data.toString().split("-")[0] + "\n" + snapshot.data.toString().split("-")[1],
                              style:
                                  kHeadingTextStyle.copyWith(color: Colors.white),
                            ),
                          );
                          }
                          
                        }
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
                              text: "Chi tiết về giao dịch\n",
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
                      FlatButton(
                        onPressed: () {
                          Future.delayed(Duration(seconds: 3));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UserSeeMore()));
                        },
                        child: Text(
                          "Xem thêm",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 30,
                            color: kShadowColor,
                          ),
                        ],
                      ),
                      child: StreamBuilder(
                          stream: bloc.userTotalTransactionStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Counter(
                                    color: kInfectedColor,
                                    number: snapshot.hasData
                                        ? snapshot.data[0]
                                        : null,
                                    title: "Doanh Thu",
                                  ),
                                  Counter(
                                    color: kDeathColor,
                                    number: snapshot.data[1],
                                    title: "Chi Phí",
                                  ),
                                  Counter(
                                    color: kRecovercolor,
                                    number: (int.parse(snapshot.data[0]) -
                                            int.parse(snapshot.data[1]))
                                        .toString(),
                                    title: "Lợi Nhuận",
                                  ),
                                ],
                              );
                            } else {
                              return CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color(0xFF3383CD)),
                              );
                            }
                          })),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowCategories()));
                    },
                                      child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey
                          ),
                          color: Colors.white
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left:45.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.add,color: Colors.grey),
                              Text('ADD NEW TRANSACTION'
                              ,style: TextStyle(color: Colors.grey),),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Counter extends StatelessWidget {
  final String number;
  final Color color;
  final String title;
  const Counter({
    Key key,
    this.color,
    this.number,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(6),
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(.26),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: color,
                width: 2,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          formatMoney(number),
          style: TextStyle(fontSize: 20, color: color),
        ),
        Text(title, style: kSubTextStyle),
      ],
    );
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
