import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loginui/constant.dart';
import 'package:loginui/models/userModel.dart';
void main() {
  runApp(InvestorPage());
}

class InvestorPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Store Page',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        fontFamily: "Poppins",
        
      ),
      
    );
  }
}

class InvestorHomeScreen extends StatelessWidget{
  InvestorHomeScreen(this.user);
  final User user;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
               child: Container(
                 padding: EdgeInsets.only(left:40,top:50,right:20),
                height:350,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFF3383CD),
                      Color(0xFF11249F)
                    ]
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/images/virus.png"),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset("assets/icons/menu.svg")
                      ),
                      SizedBox(height: 20,),
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            SvgPicture.asset("assets/icons/investor.svg",
                            width: 200,
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                            ),
                            Positioned(
                              top: 20,
                              left: 200,
                              child: Text(
                                "Xin Chào \nÔng " + user.fullName,style: kHeadingTextStyle.copyWith(color: Colors.white) ,
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
              padding: EdgeInsets.symmetric(horizontal:20),
              child: Column(children: <Widget>[
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
                            text: "Từ 1 tháng 5 đến 31 tháng 5",
                            style: TextStyle(
                              color:kTextLightColor,
                            )
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Xem thêm",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                PreventCard(
                  title: "Passio FPT",
                  content: "Without store supplies, work is harder than I expected. I want to use some money to buy store supplies for the next few weeks",
                  money: 2,
                  color: kDeathColor,
                ),
                PreventCard(
                  title: "Passio Nguyen Dinh Chieu",
                  content: "We have just received some cash as a partial of payment from online orders",
                  money: 3,
                  color: kRecovercolor,
                ),
                PreventCard(
                  title: "Passio Dien Bien Phu",
                  content: "Maintaining",
                  money: 1,
                  color: kInfectedColor,
                ),
              ],),
            ),
        ],),
      ),
    );
  }
}

class PreventCard extends StatelessWidget {
  final String title;
  final String content;
  final int money;
  final Color color;
  const PreventCard({
    Key key, this.title, this.content, this.money, this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Stack(
        children:<Widget>[
          Container(
            height:136,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0,8),
                  blurRadius: 24,
                  color: kShadowColor,
                  )
                ],
            ),
          ),
          Positioned(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal:20, vertical:15),
              height: 150,
              width: MediaQuery.of(context).size.width-50,
              child: Column(
                crossAxisAlignment : CrossAxisAlignment.start,
                children:<Widget>[
                  Text(
                    title,
                    style: kTitleTextstyle.copyWith(fontSize: 16),
                  ),
                  Text(
                    content,
                    style: TextStyle(fontSize:12),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child:Text(
                      "$money M",
                      style: TextStyle(fontSize: 20,color: color),
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


class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(size.width/2, size.height, size.width, size.height-80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper){
    return false;
  }
}