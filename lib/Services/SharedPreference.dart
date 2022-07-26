import 'package:agrosnap/Models/StoreOwner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHandler {

  static setImg({required int id, required String img}) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("$id", img);
    } catch (_) {}
  }

  static getImg({required int id}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('$id');
    } catch (_) {}
    return null;
  }

  static removeImg({required int id}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("$id");
    } catch (_) {}
  }

  static setMode({required bool value}) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("Mode", value);
    } catch (_) {}
  }

  static setFontSize({required value}) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("Size", value);
    } catch (_) {}
  }

  static setLanguage({required value}) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("Language", value);
    } catch (_) {}
  }

  static getMode() async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool("Mode");
    } catch (_) {}
  }

  static getFontSize() async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getInt("Size");
    } catch (_) {}
  }

  static getLanguage() async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getInt("Language");
    } catch (_) {}
  }

  static setSawIntro() async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('intro', true);
    } catch (_) {}
  }

  static Future<bool?> getSawIntro() async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool("intro");
    } catch (_) {}
  }

  static setStore({required StoreOwner store}) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('id', store.id??"");
      prefs.setString('name', store.name??"");
      prefs.setString('image', store.img??"");
      prefs.setString('phone', store.phoneNumber??"");
      prefs.setString('face', store.faceLink??"");
      prefs.setString('another', store.anotherLink??"");
      prefs.setDouble('lat', store.lat??0.0);
      prefs.setDouble('long', store.long??0.0);
    } catch (_) {}
  }

  static Future<StoreOwner> getStore() async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      StoreOwner store = StoreOwner(
        id: prefs.getString("id"),
        name: prefs.getString("name"),
        img: prefs.getString("image"),
        phoneNumber: prefs.getString("phone"),
        faceLink: prefs.getString("face"),
        anotherLink: prefs.getString("another"),
        lat: prefs.getDouble("lat"),
        long: prefs.getDouble("long"),
      );
      return store;
    } catch (_) {}
    return StoreOwner();
  }

  static deleteStore() async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("id");
      prefs.remove("name");
      prefs.remove("image");
      prefs.remove("phone");
      prefs.remove("face");
      prefs.remove("another");
      prefs.remove("lat");
      prefs.remove("long");
    } catch (_) {}
  }
}