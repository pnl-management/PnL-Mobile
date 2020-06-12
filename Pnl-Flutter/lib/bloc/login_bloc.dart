

import 'package:loginui/resource/login_validations.dart';
import 'dart:async';

class LoginBloc{
  StreamController _user = new StreamController();
  Stream get userStream =>  _user.stream; 
  
  Future<bool> loginRole() async{
    print("bloc alo");
    var loginValidation = new LoginValidations();
    var result = await loginValidation.login();
    if(result==null){
      _user.sink.addError("Not signed up yet");
      return false;
    }else{
      _user.sink.add(result);
      return true;
    }
  }
  void dispose(){
    _user.close();
  }
}