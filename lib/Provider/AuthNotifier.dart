import 'package:agrosnap/Models/StoreOwner.dart';
import 'package:agrosnap/Screens/Home/Home.dart';
import 'package:agrosnap/Services/API.dart';
import 'package:agrosnap/Services/SharedPreference.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthNotifier extends ChangeNotifier{
  String email = "", password = "", storeName = "";
  bool loading = false;
  StoreOwner store = StoreOwner();

  void setEmail({required String input}){email=input;}

  void setPassword({required String input}){password=input;}

  void setStoreName({required String input}){storeName=input;}


  Future<bool> register({required bool arabic,required bool dark}) async{
    loading =true;
    notifyListeners();
    final result = await API.register(email: email, password: password, storeName: storeName);
    loading = false;
    notifyListeners();
    if(result==false){
      General.buildToast(msg: (arabic)?"المتجر موجود بالفعل":"store is already exist", dark: dark);
    }
    else {
      store = StoreOwner(id: result,name: storeName);
      SharedPreferenceHandler.setStore(store: store);
      return true;
    }
    return false;
  }

  Future<bool> login({required bool arabic,required bool dark}) async{
    loading =true;
    notifyListeners();
    final result = await API.login(email: email, password: password);
    loading = false;
    notifyListeners();
    if(result == false || result == null){
      General.buildToast(msg: (arabic)?"البريد الإلكتروني أو كلمة المرور غير صحيحة":"Incorrect email or password", dark: dark);
    }
    else {
      store = StoreOwner.fromJson(result,true);
      SharedPreferenceHandler.setStore(store: store);
      return true;
    }
    return false;
  }

  Future<bool> getMyStore() async{
    store = await SharedPreferenceHandler.getStore();
    if(store.id==null||store.id=="")
      return false;
    return true;
  }

  void logOut() async{
    await SharedPreferenceHandler.deleteStore();
  }

  Future deleteAccount({required String id,required bool dark,required bool arabic,context}) async{
    bool response = await API.deleteAccount(id: id);
    if(response){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Directionality(
          textDirection: (arabic)?TextDirection.rtl:TextDirection.ltr,child: Home(dark: dark))),
              (route) => false);
      logOut();
    }
  }
}