import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loginui/constant/constant.dart';
import 'package:loginui/main.dart';
import 'package:loginui/models/userModel.dart';
import 'package:http/http.dart' as http;
class LoginValidations{
  FirebaseAuth _auth;
  GoogleSignIn googleSignIn;

  LoginValidations(){
    this._auth = FirebaseAuth.instance;
    this.googleSignIn = new GoogleSignIn();

  }
  Future<User> login() async {
    print("validation alo");
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth =
        await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    FirebaseUser currentUser = await _auth.currentUser();
    String token;
    await currentUser.getIdToken().then((value) {
      token = value.token;
      print("Main Token:" + token);
    });
    String url = apiUrl + "/api/login";
    var response =
        await http.post(Uri.encodeFull(url), headers: {"Authorization": token});
        print(response.body);
    if (response.statusCode == 200) {
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
          fullName: participant['fullname'].toString());
    } else {
      return null;
    }
  }
  Future<void> logout(context) async {
    await _auth.signOut();
    await googleSignIn.signOut();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyLoginPage()), (route) => false);
  }
}