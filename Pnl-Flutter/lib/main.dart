
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginui/constant/constant.dart';
import 'package:loginui/models/userModel.dart';
import 'package:loginui/ui/user.dart';
import 'package:loginui/ui/investor.dart';

import 'bloc/login_bloc.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatelessWidget {
  LoginBloc bloc = new LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Stack(
            alignment: Alignment.center,
            children: <Widget>[  
              new Container(
                child: StreamBuilder(
                stream: bloc.userStream,
                builder: (context, snapshot){
                var user = snapshot.data;
                loginNavigator(user, context,snapshot.error);
                return Container();
                  } 
                ),
              ),
              new Container(
                height: 60.0,
                width: 60.0,
                decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(50.0),
                    color: Color(0xFFFC6A7F)),
                child: new Icon(Icons.home, color: Colors.white),
              ),
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 80.0),
                child: new Text(
                  "PnL Báo Cáo",
                  style: new TextStyle(fontSize: 30.0),
                ), 
              )
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                  onPressed: () { 
                    bloc.loginRole();
                  },
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text("Login With Google"),
                ),
              
            ],
          ),
        ],
      ),
    ));
  }
  void loginNavigator(User value,BuildContext context,String error){
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if(value !=null){
      if (value.role.toString() == userRole) {
      var navigator = Navigator.push(
      context,
      new MaterialPageRoute(
         builder: (context) => new UserHomeScreen(value)));
      if (navigator == true) {
        Fluttertoast.showToast(msg: "Signed as " + value.fullName,
                            toastLength: Toast.LENGTH_LONG,
                            );
      }
    }
    if (value.role.toString() == investorRole) {
      var navigator = Navigator.push(
      context,
      new MaterialPageRoute(
         builder: (context) => new InvestorHomeScreen(value)));
      if (navigator == true) {
        Fluttertoast.showToast(msg: "Signed as " + value.fullName,
                            toastLength: Toast.LENGTH_LONG,
                            );
      }
    }
    if(value.role.toString() == accountantRole){
      Fluttertoast.showToast(msg: "Accountant is not allowed to use mobile app",
                            toastLength: Toast.LENGTH_LONG,
                            );
    }}
    if(error!=null){
      Fluttertoast.showToast(msg: error,
                            toastLength: Toast.LENGTH_LONG,
                            );
    }
    
     });
    
  }
}
