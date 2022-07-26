import 'dart:io';
import 'package:agrosnap/Models/Product.dart';
import 'package:agrosnap/Models/StoreOwner.dart';
import 'package:agrosnap/Services/API.dart';
import 'package:agrosnap/Services/OtherServices.dart';
import 'package:agrosnap/Services/SharedPreference.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class StorePageNotifier extends ChangeNotifier{
  int index = 0;
  File? newProfileImg;
  File? productImg;
  String profileImg = "";
  List<StoreOwner> stores = [];
  bool loading = true;
  StoreOwner store = StoreOwner();
  List<Product> products = [];
  Product product = Product();
  Product recommendedProduct = Product();
  bool productLoading = false;


  String get getProfileImg => profileImg;
  File? get getProductImg => productImg;

  void setIndex({required int value}){
    index = value;
    notifyListeners();
  }

  void getImgFromPhone({required bool isCamera,required bool pProduct,context,required bool dark,required bool arabic}) async{
    XFile img = await OtherServices.getImgFromPhone(isCamera: isCamera, base64: false);
    File image = File(img.path);
    (pProduct)? productImg = image : newProfileImg = image;
    notifyListeners();
    if(newProfileImg!=null)
      General.buildDialog(context: context, title: "تحديث صورة الملف الشخصي", content: SizedBox(), dark: dark,
        actionText: "تحديث",function: () async{
          if(store.lat!=0.0&&store.long!=0.0){
            String fName = "stores/${store.id}/image/";
            String url = await API.uploadImage(image: image,folderName: fName);
            profileImg = url;
            store.img=url;
            bool result = await API.editInfo(store: store);
            SharedPreferenceHandler.setStore(store: store);
            print(store.img);
            if(result == false)
              General.buildToast(msg: (arabic)?"تحقق من اتصالك بالإنترنت":"check your internet connection", dark: dark);
          }
          else
            General.buildToast(msg: (arabic)?"ادخل موقعك الجغرافي":"Enter your Location", dark: dark);
      }
    );
  }

  void setMyStore({required StoreOwner myStore,required bool dark,required bool arabic}){
    store = myStore;
    profileImg = myStore.img??"";
    productLoading = true;
    //notifyListeners();
    getAllProducts(arabic: arabic, dark: dark);
  }

  void getAllStores({required bool dark,required bool arabic}) async{
    final response = await API.getAllStores();
    if(response == false || response == null)
      General.buildToast(msg: (arabic)?"تحقق من اتصالك بالإنترنت":"check your internet connection", dark: dark);
    else
      stores = response;
    loading = false;
    notifyListeners();
  }

  void setData({required String input,required String type}){
    switch(type){
      case "name":
        store.name = input;
        break;
      case "phone":
        store.phoneNumber = input;
        break;
      case "facebook":
        store.faceLink = input;
        break;
      case "another":
        store.anotherLink = input;
        break;
      case "productPrice":
        product.price = double.parse(input);
        break;
      case "productName":
        product.name = input;
        break;
    }
    print(product.name);
    print(product.price);
  }

  void setLatLng({required LatLng latLng,required bool arabic,required bool dark}) async{
    store.long = latLng.longitude;
    store.lat = latLng.latitude;
    notifyListeners();
    bool result = await API.editInfo(store: store);
    SharedPreferenceHandler.setStore(store: store);
    if(result == false)
      General.buildToast(msg: (arabic)?"تحقق من اتصالك بالإنترنت":"check your internet connection", dark: dark);
  }

  void editStore({required bool arabic,required bool dark}) async{
    if(store.lat!=0.0&&store.long!=0.0){
      bool result = await API.editInfo(store: store);
      SharedPreferenceHandler.setStore(store: store);
      if(result == false)
        General.buildToast(msg: (arabic)?"تحقق من اتصالك بالإنترنت":"check your internet connection", dark: dark);
    }
    else
      General.buildToast(msg: (arabic)?"ادخل موقعك الجغرافي":"Enter your Location", dark: dark);
  }

  Future getStore({required String id,required String name,String? img,required bool arabic,required bool dark}) async{
    profileImg = img??"";
    store.img = img??"";
    store.name = name;
    store.id = id;
    final result = await API.getStore(id: id);
    if(result!=false&&result!=null){
      store = result;
      productLoading = true;
      notifyListeners();
      getAllProducts(arabic: arabic, dark: dark);
    }
  }

  void setProduct({required Product pProduct}){product = pProduct;}

  Future addProduct({required bool arabic,required bool dark}) async{
    print(product.name);
    print(product.price);
    if(product.name!=""&&product.price!=0.0){
      if(productImg!=null){
        String fName = "stores/${store.id}/products/${product.name}/";
        String url = await API.uploadImage(image: productImg!,folderName: fName);
        product.image = url;
      }
      print(product.name);
      print(product.price);
      print(product.image);
      final result = await API.addProduct(storeID: store.id??"",product: product);
      if(result == "exist")
        General.buildToast(msg: (arabic)?"المنتج موجود بالفعل":"product is already exist", dark: dark);
      else if(result == false || result == null)
        General.buildToast(msg: (arabic)?"تحقق من اتصالك بالإنترنت":"check your internet connection", dark: dark);
      else{
        product.id = result;
        products.add(product);
        notifyListeners();
      }
    }
    productImg=null;
    product=Product();
  }

  Future editProduct({required bool arabic,required bool dark}) async{
    if(product.name!=""&&product.price!=0.0){
      if(productImg!=null){
        String fName = "stores/${store.id}/products/";
        String url = await API.uploadImage(image: productImg!,folderName: fName);
        product.image = url;
      }
      print(product.name);
      print(product.price);
      print(product.image);
      final result = await API.editProduct(product: product);
      if(result == "This product already exists. Try another one.")
        General.buildToast(msg: (arabic)?"المنتج موجود بالفعل":"product is already exist", dark: dark);
      else if(result == false || result == null)
        General.buildToast(msg: (arabic)?"تحقق من اتصالك بالإنترنت":"check your internet connection", dark: dark);
      else if(result=="product updated successfully.")
        General.buildToast(msg: (arabic)?"تم تعديل المنتج بنجاح":"product updated successfully", dark: dark);
    }
    productImg=null;
    product=Product();
  }

  Future deleteProduct({required bool arabic,required bool dark}) async{
    if(product.id!=""&&product.id!=null){
      print(product.id);
      final result = await API.deleteProduct(id: product.id??"");
      if(result == false)
        General.buildToast(msg: (arabic)?"تحقق من اتصالك بالإنترنت":"check your internet connection", dark: dark);
      else if(result=="product deleted successfully.")
        General.buildToast(msg: (arabic)?"تم مسح المنتج بنجاح":"product deleted successfully", dark: dark);
    }
  }

  Future getAllProducts({required bool arabic,required bool dark}) async{
    final response = await API.getAllProducts(storeID:store.id??"");
    if(response == false || response == null)
      General.buildToast(msg: (arabic)?"تحقق من اتصالك بالإنترنت":"check your internet connection", dark: dark);
    else {
      products = response;
      productLoading = false;
      notifyListeners();
    }
  }

  void getSearchedStores({required bool dark,required bool arabic,required String search}) async{
    loading = true;
    notifyListeners();
    final response = await API.getSearchedStores(search: search);
    if(response == false || response == null)
      General.buildToast(msg: (arabic)?"تحقق من اتصالك بالإنترنت":"check your internet connection", dark: dark);
    else
      stores = response;
    loading = false;
    notifyListeners();
  }
}