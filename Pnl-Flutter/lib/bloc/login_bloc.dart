import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:loginui/constant/constant.dart';
import 'package:loginui/resource/login_validations.dart';
import 'package:loginui/ui/investor.dart';
import 'dart:async';

import 'package:loginui/ui/user.dart';
import 'package:loginui/ui/widget/investor_menu.dart';
import 'package:loginui/ui/widget/user_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc {
  StreamController _user = new StreamController();
  Stream get userStream => _user.stream;

  Future<bool> loginRole(context) async {
    print("bloc alo");
   
    var loginValidation = new LoginValidations();
    var result = await loginValidation.login();
    if (result == null) {
      _user.sink.addError("Not signed up yet");
    } else {
      print("else alo");
      SharedPreferences pref = await SharedPreferences.getInstance();
      print(pref.toString());
      await pref.setString("account", json.encode(result));
      print(result.role.toString());
      if (result.role.toString() == userRole) {
        print("push");
        var navigator = Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => UserMenuPage(screen: UserHomeScreen())));
      }
      if (result.role.toString() == investorRole) {
        var navigator = Navigator.push(context,
           MaterialPageRoute(
                builder: (context) => InvestorMenuPage(screen: InvestorPage())));
      }
      return true;
    }
  }

  Future<void> logoutBloc(context) async {
    var loginValidation = new LoginValidations();
    await loginValidation.logout(context);
  }

  void dispose() {
    _user.close();
  }
}
