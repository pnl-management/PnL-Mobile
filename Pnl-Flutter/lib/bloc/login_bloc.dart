import 'package:loginui/models/userModel.dart';
import 'package:loginui/resource/login_validations.dart';
import 'dart:async';

class LoginBloc{
  StreamController _user = new StreamController();
  Stream get userStream =>  _user.stream; 
  
  Future<User> loginRole(){
    print("bloc alo");
    var loginValidation = new LoginValidations();
    var result = loginValidation.login();
    if(result==null){
      _user.sink.addError("Not signed up yet");
      return null;
    }else{
      _user.sink.add(result);
      return result;
    }
    
  }
  void dispose(){
    _user.close();
  }
}