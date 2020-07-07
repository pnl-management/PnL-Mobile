import 'dart:convert';

import 'package:loginui/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetSharedPref{
  Future<User> getUserInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var object = pref.getString("account");
    print(object);
    User user = User.fromJSON(json.decode(object));
    return user;  
  }
}