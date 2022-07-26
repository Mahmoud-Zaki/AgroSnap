import 'dart:io';
import 'package:agrosnap/Models/PlantInformation.dart';
import 'package:agrosnap/Models/Product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:convert';
import 'package:agrosnap/Models/ArticleAndAdvice.dart';
import 'package:agrosnap/Models/StoreOwner.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:http/http.dart' as http;

class API {
  static Future getAllStores() async {
    try {
      Uri uri = Uri.parse(Constants.baseURL + 'getAllStores');
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        List list = jsonDecode(response.body);
        List<StoreOwner> stores = [];
        list.forEach((element) {stores.add(StoreOwner.fromJson(element,false));});
        return stores;
      }
      else
        return false;
    } catch (e) {
      print(e.toString());
    }
  }

  static Future getStore({required String id}) async {
    try {
      Uri uri = Uri.parse(Constants.baseURL + 'storeDetail/$id');
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        StoreOwner store = StoreOwner.fromJson(result, true);
        return store;
      }
      else
        return false;
    } catch (e) {
      print(e.toString());
    }
  }

  static Future getAllArticlesOrAdvice({required bool arabic,required bool articles}) async {
    try {
      String urlPart2 = (articles)?"article_titles/":"advice_titles/";
      String urlPart3 = (arabic)?"arabic":"english";
      Uri uri = Uri.parse(Constants.baseURL + urlPart2 + urlPart3);
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        List list = jsonDecode(response.body);
        List<ArticleAndAdvice> articleAndAdvice = [];
        list.forEach((element) {articleAndAdvice.add(ArticleAndAdvice.fromJson(element,arabic));});
        return articleAndAdvice;
      }
      else
        return false;
    } catch (e) {
      print(e.toString());
    }
  }

  static Future getArticlesOrAdviceContent({required bool arabic,required bool advice,required String id}) async {
    try {
      String urlPart2 = (!advice)?"articleDetail/":"adviceDetail/";
      String urlPart3 = (arabic)?"arabic/":"english/";
      Uri uri = Uri.parse(Constants.baseURL + urlPart2 + urlPart3 + id);
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        String content = "";
        if(advice)
          content = (arabic)?result["adviceInArabic"]:result["adviceInEnglish"];
        else
          content = (arabic)?result["articleInArabic"]:result["articleInEnglish"];

        return content;
      }
      else
        return "";
    } catch (e) {
      print(e.toString());
    }
  }

  static Future register({required String email,required String password,required String storeName}) async {
    try {
      Uri uri = Uri.parse(Constants.baseURL + 'signup');
      final response = await http.post(
        uri,headers: {'Content-Type': 'application/json'}, body: jsonEncode({"email": email, "password": password, "storeName": storeName})
      );
      if (response.statusCode == 200){
        var result = jsonDecode(response.body);
        if(result == "This email already has an store. Try another one.")
          return false;
        return result["_id"]["\$oid"];
      }
    } catch (e) {
      print("error"+e.toString());
      return false;
    }
    return false;
  }

  static Future login({required String email,required String password}) async {
    try {
      Uri uri = Uri.parse(Constants.baseURL + 'login');
      final response = await http.post(
          uri,headers: {'Content-Type': 'application/json'},
          body: jsonEncode({"email": email, "password": password})
      );
      if (response.statusCode == 200){
        final result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      print('error'+e.toString());
      return false;
    }
    return false;
  }

  static Future<bool> deleteAccount({required String id}) async {
    try {
      Uri uri = Uri.parse(Constants.baseURL + 'delete_account');
      final response = await http.delete(uri,
        headers: {'Content-Type': 'application/json'}, body: jsonEncode({"ID": id}));
      if (response.statusCode == 200)
          return true;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  static Future uploadImage({required File image,required String folderName}) async{
    final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
    var snapshot = await _firebaseStorage.ref()
        .child(folderName)
        .putFile(image);
    var downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  static Future<bool> editInfo({required StoreOwner store}) async {
    try {
      Uri uri = Uri.parse(Constants.baseURL + 'edit_profile');
      final response = await http.put(uri,
          headers: {'Content-Type': 'application/json'},body: jsonEncode({
            "ID": store.id, "storeName": store.name, "phone_number": store.phoneNumber,
            "facebook_link": store.faceLink, "another_link": store.anotherLink, "image": store.img,
            "long": store.long, "lat": store.lat
          }));
      if (response.statusCode == 200)
        return true;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  static Future addProduct({required Product product,required String storeID}) async {
    try {
      Uri uri = Uri.parse(Constants.baseURL + 'add');
      final response = await http.post(
        uri,headers: {'Content-Type': 'application/json'}, body: jsonEncode({
        "store_id": storeID, "name": product.name,"image":product.image,"price":product.price})
      );
      if (response.statusCode == 200){
        final result = jsonDecode(response.body);
        if(result=="This product already exists. Try another one.")
          return "exist";
        return result["_id"]["\$oid"];
      }
    } catch (e) {
      print('error'+e.toString());
      return false;
    }
    return false;
  }

  static Future editProduct({required Product product}) async {
    try {
      Uri uri = Uri.parse(Constants.baseURL + 'edit_product');
      final response = await http.put(
        uri,headers: {'Content-Type': 'application/json'}, body: jsonEncode({
        "ID":product.id,"name": product.name,"image":product.image,"price":product.price})
      );
      if (response.statusCode == 200){
        final result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      print('error'+e.toString());
      return false;
    }
    return false;
  }

  static Future<bool> deleteProduct({required String id}) async {
    try {
      Uri uri = Uri.parse(Constants.baseURL + 'delete_product');
      final response = await http.delete(uri,headers: {'Content-Type': 'application/json'}, body: jsonEncode({"ID": id}));
      if (response.statusCode == 200)
        return true;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  static Future getAllProducts({required String storeID}) async {
    try {
      Uri uri = Uri.parse(Constants.baseURL + 'viewAllProducts/$storeID');
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        List list = jsonDecode(response.body);
        List<Product> products = [];
        list.forEach((element) {products.add(Product.fromJson(element));});
        return products;
      }
      else
        return false;
    } catch (e) {
      print(e.toString());
    }
  }

  static Future getSearchedStores({required String search}) async {
    try {
      Uri uri = Uri.parse(Constants.baseURL + 'searchStore/$search');
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        List list = jsonDecode(response.body);
        List<StoreOwner> stores = [];
        list.forEach((element) {stores.add(StoreOwner.fromJson(element,false));});
        return stores;
      }
      else
        return false;
    } catch (e) {
      print(e.toString());
    }
  }

  static Future getAllPlants() async {
    try {
      Uri uri = Uri.parse(Constants.baseURL + 'getAllPlants');
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        List list = jsonDecode(response.body);
        List<PlantInfo> plants = [];
        list.forEach((element) {plants.add(PlantInfo.fromJson(element));});
        return plants;
      }
      else
        return false;
    } catch (e) {
      print(e.toString());
    }
  }

  static Future getSearchedPlants({required String search}) async {
    try {
      Uri uri = Uri.parse(Constants.baseURL + 'searchPlant/$search');
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        List list = jsonDecode(response.body);
        List<PlantInfo> plants = [];
        list.forEach((element) {plants.add(PlantInfo.fromJson(element));});
        return plants;
      }
      else
        return false;
    } catch (e) {
      print(e.toString());
    }
  }

  static Future getPlant({required String id}) async {
    try {
      Uri uri = Uri.parse(Constants.baseURL + 'plantById/$id/english');
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      }
      else
        return false;
    } catch (e) {
      print(e.toString());
    }
  }

  static Future location({required String name, required double lat, required double long}) async{
    try {
      Uri uri = Uri.parse(Constants.baseURL + 'location');
      final response = await http.post(
          uri, headers: {'Content-Type': 'application/json'}, body: jsonEncode({
        "name": name,
        "lat1": lat,
        "long1": long
      })
      );
      if (response.statusCode == 200) {
        List list = jsonDecode(response.body);
        List<StoreOwner> stores = [];
        list.forEach((element) {stores.add(StoreOwner.fromJson(element,false));});
        return stores;
      }
    } catch (e) {
      print('error' + e.toString());
      return false;
    }
    return false;
  }

  static Future disease({required String img}) async {
    try {
      Uri uri = Uri.parse(Constants.baseURL + 'plantDisease');
      final response = await http.post(
          uri, headers: {'Content-Type': 'application/json'}, body: jsonEncode({
        "model_type": "d",
        "base64_image": img
      })
      );
      if (response.statusCode == 200) {
        if (response.body == "Not found.")
          return "Not Found";
        final result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      print('error' + e.toString());
      return false;
    }
    return false;
  }

  static Future healthy({required String img}) async {
    try {
      Uri uri = Uri.parse(Constants.baseURL + 'healthy');
      final response = await http.post(
          uri, headers: {'Content-Type': 'application/json'}, body: jsonEncode({
        "model_type": "h",
        "base64_image": img
      })
      );
      if (response.statusCode == 200) {
        if (response.body == "Not found.")
          return "Not Found";
        final result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      print('error' + e.toString());
      return false;
    }
    return false;
  }

  static Future fruits({required String img}) async {
    try {
      Uri uri = Uri.parse(Constants.baseURL + 'fruit');
      final response = await http.post(
          uri, headers: {'Content-Type': 'application/json'}, body: jsonEncode({
        "model_type": "f",
        "base64_image": img
      })
      );
      if (response.statusCode == 200) {
        if (response.body == "Not found.")
          return "Not Found";
        final result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      print('error' + e.toString());
      return false;
    }
    return false;
  }
}