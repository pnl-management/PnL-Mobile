import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loginui/constant.dart';

void main() {
  runApp(TransactionDetailUserPage());
}

class TransactionDetailUserPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Store Page',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        fontFamily: "Poppins",
        
      ),
      home: TransactionDetailUserScreen(),
    );
  }
}

class TransactionDetailUserScreen extends StatelessWidget{
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
                            SvgPicture.asset("assets/icons/phone.svg",
                            width: 200,
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                            ),
                            Positioned(
                              top: 20,
                              left: 200,
                              child: Text(
                                "Chi Tiết \nGiao Dịch",style: kHeadingTextStyle.copyWith(color: Colors.white) ,
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
                            text: "Mã Hoá Đơn\n",
                            style: kTitleTextstyle,
                          ),
                          TextSpan(
                            text: "#XXXXXXXXX",
                            style: TextStyle(
                              color:kTextLightColor,
                            )
                          ),
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
                  title: "Trạng Thái",
                  content: "Chờ phản hồi",
                  height:100,
                ),
                PreventCard(
                  title: "Loại giao dịch",
                  content: "Chi phí",
                  height:100,
                ),
                PreventCard(
                  title: "Tên giao dịch",
                  content: "Chi phí khác",
                  height:100,
                ),
                PreventCard(
                  title: "Ngày Tạo",
                  content: "28/03/2020",
                  height:100,
                ),
                PreventCard(
                  title: "Số Tiền",
                  content: "3M",
                  height:100,
                ),
                PreventCard(
                  title: "Mô Tả",
                  content: "Without store supplies, work is harder than I expected. I want to use some money to buy store supplies for the next few weeks",
                  height:200,
                ),
                SizedBox(
                  height: 420,
                  child: Stack(
                    children:<Widget>[
                      Container(
                        height:400,
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
                        padding: EdgeInsets.symmetric(horizontal:20),
                        height: 400,
                        width: MediaQuery.of(context).size.width-50,
                        child: Column(
                          crossAxisAlignment : CrossAxisAlignment.start,
                          children:<Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom:8),
                            child: Text(
                              "Bằng Chứng",
                              style: kTitleTextstyle.copyWith(fontSize: 16),
                            ),
                          ),
                          Image(
                            image: AssetImage(
                              "assets/images/receipt.png"),
                            height: 350,
                          ),
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
                    padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      decoration: new BoxDecoration(color: Color(0xFFDF513B),borderRadius: new BorderRadius.circular(10.0),),
                      child: new Text("Chỉnh Sửa",style: new TextStyle(fontSize:20.0,color:Colors.white)),
                  ),
                  ),
                ),
                Expanded(
                    child: Padding(
                    padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      decoration: new BoxDecoration(color: kRecovercolor,borderRadius: new BorderRadius.circular(10.0),),
                      child: new Text("Tạo G.Dịch Con",style: new TextStyle(fontSize:20.0,color:Colors.white)),
                  ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
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
  final double height;
  const PreventCard({
    Key key, this.title, this.content, this.height, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        children:<Widget>[
          Container(
            height:height,
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
              padding: EdgeInsets.symmetric(horizontal:20),
              height: height,
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
                    style: TextStyle(fontSize:16),
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