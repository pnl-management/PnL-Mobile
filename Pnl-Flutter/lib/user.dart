import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loginui/constant.dart';
import 'package:loginui/models/userModel.dart';

void main() {
  runApp(UserPage());
}

class UserPage extends StatelessWidget{
  
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

class UserHomeScreen extends StatelessWidget{
  UserHomeScreen(this.user);
  final User user;
  
  @override
  Widget build(BuildContext context){
    print("token : " + user.token);
    return Scaffold(
      body: Column(
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
                          SvgPicture.asset("assets/icons/shop.svg",
                          width: 150,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                          ),
                          Positioned(
                            top: 20,
                            left: 200,
                            
                            child: Text(
                              user.brandName + "\n" + user.storeName,style: kHeadingTextStyle.copyWith(color: Colors.white) ,
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
                          text: "Chi tiết về giao dịch\n",
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
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow:[
                    BoxShadow(
                      offset: Offset(0,4),
                      blurRadius: 30,
                      color: kShadowColor,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Counter(
                      color: kInfectedColor,
                      number: 30,
                      title: "Doanh Thu",
                      ),
                    Counter(
                      color: kDeathColor,
                      number: 5,
                      title: "Chi Phí",
                      ),
                    Counter(
                      color: kRecovercolor,
                      number: 25,
                      title: "Lợi Nhuận",
                      ),
                  ],
                ),
              ),
            ],),
          ),
      ],),
    );
  }
}

class Counter extends StatelessWidget {
  final int number;
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
                width:2,
              ),
            ),
          ),
        ),
        SizedBox(height:10),
        Text(
          "$number M",
          style: TextStyle(fontSize: 40,color: color),
        ),
        Text(title, style : kSubTextStyle),
      ],
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