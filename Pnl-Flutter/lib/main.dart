
import 'package:flutter/material.dart';
import 'package:loginui/constant/constant.dart';
import 'package:loginui/models/userModel.dart';
import 'package:loginui/ui/user.dart';
import 'package:loginui/ui/investor.dart';
import 'package:loginui/bloc/login_bloc.dart';

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
              new Container(),
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
              StreamBuilder(
                stream: bloc.userStream,
                builder: (context, snapshot) => MaterialButton(
                  onPressed: () { 
                    bloc.loginRole();
                    Future<User> cur = snapshot.data;
                    cur.then((value){
                      if (value.role.toString() == userRole) {
                      var navigator = Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new UserHomeScreen(value)));
                      if (navigator == true) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text("Success"),
                                ));
                      }
                    }
                    if (value.role.toString() == investorRole) {
                      var navigator = Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => InvestorHomeScreen(value)));
                      if (navigator == true) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text("Success"),
                                ));
                      }
                    }
                    if(value.role.toString() == accountantRole){
                      if(snapshot.hasError){
                        return AlertDialog(
                          title: Text('Invalid Role'),
                          content: Text(snapshot.error),
                        );
                      }
                    }
                    });
                    
                   
                    
                  },
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text("Login With Google"),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}
