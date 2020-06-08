import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loginui/constant.dart';
import 'package:loginui/models/userModel.dart';
import 'package:loginui/user.dart' ;
import 'package:loginui/investor.dart' ;
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
      theme: ThemeData(
      ),
      home: MyLoginPage(),
    );
    
  }
}



class MyLoginPage extends StatelessWidget{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  Future<User> _login() async{
    GoogleSignInAccount googleSignInAccount= await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    FirebaseUser currentUser = await _auth.currentUser();
    String token;
    await currentUser.getIdToken().then((value){
      token = value.token;
      print("Main Token:" + token);
    } );
    String url = apiUrl+"/api/login";
    var response = await http.post(Uri.encodeFull(url), headers: {
      "Authorization" : token});
      if(response.statusCode == 200){
          final data = json.decode(response.body);
          final participant = data['participant'];
          final store = participant['store'];
          final brand = participant['brand'];
          return User(
          token: data['token'],
          role: participant['role'].toString(),
          brandId: brand['id'].toString(),
          brandName: brand['name'].toString(),
          storeId: store['id'].toString(),
          storeName: store['name'].toString(),
          fullName: participant['fullname'].toString()
        );
      }else{
        Fluttertoast.showToast(
          msg: "This account is not signed up yet. Please signup in web",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          fontSize: 16.0
        );
      }
    
  }
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
                ),
                new Container(
                  height:60.0,
                  width:60.0,
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(50.0),
                    color: Color(0xFFFC6A7F)
                  ),
                  child: new Icon(Icons.home, color: Colors.white),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:8.0,bottom: 80.0),
                child: new Text("PnL Báo Cáo",style: new TextStyle(fontSize:30.0),),
              )
            ],),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  onPressed: (){
                    String role;
                    _login().then((value) {
                      role = value.role;
                      if(role.toString() == '2'){
                        var navigator =  Navigator.push(context, new MaterialPageRoute(builder: (context)=>new UserHomeScreen(value))
                      );
                        if(navigator == true){
                          showDialog(context: context,
                          builder : (context) => AlertDialog(title: Text("Success"),));
                        }
                      }
                      if(role.toString() == '1'){
                        var navigator =  Navigator.push(context, new MaterialPageRoute(builder: (context)=>InvestorHomeScreen(value))
                      );
                        if(navigator == true){
                          showDialog(context: context,
                          builder : (context) => AlertDialog(title: Text("Success"),));
                        }
                      }
                      // if(role.toString() == '3'){
                      //   var navigator =  Navigator.push(context, new MaterialPageRoute(builder: (context)=>UserPage())
                      // );
                      //   if(navigator == true){
                      //     showDialog(context: context,
                      //     builder : (context) => AlertDialog(title: Text("Success"),));
                      //   }
                      // }
                    });
                  },
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text("Login With Google"),
                ),
              ],
            ),

          ],
        ),
      )
    );
  }

  
}

