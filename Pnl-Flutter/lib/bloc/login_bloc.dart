import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginui/constant/constant.dart';
import 'package:loginui/resource/login_validations.dart';
import 'package:loginui/ui/investor.dart';
import 'dart:async';

import 'package:loginui/ui/user.dart';

class LoginBloc {
  StreamController _user = new StreamController();
  Stream get userStream => _user.stream;

  Future<bool> loginRole(context) async {
    print("bloc alo");
    var loginValidation = new LoginValidations();
    var result = await loginValidation.login();
    if (result == null) {
      _user.sink.addError("Not signed up yet");
      Fluttertoast.showToast(msg: "Can't log in",toastLength: Toast.LENGTH_LONG);
      return false;
    } else {
      _user.sink.add(result);
      if (result.role.toString() == userRole) {
        var navigator = Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => UserHomeScreen(result)));
      }
      if (result.role.toString() == investorRole) {
        var navigator = Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InvestorHomeScreen(result)));
      }
      return true;
    }
  }

  void dispose() {
    _user.close();
  }
}
