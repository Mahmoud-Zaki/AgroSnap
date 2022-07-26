import 'package:agrosnap/Models/PlantInformation.dart';
import 'package:agrosnap/Models/StoreOwner.dart';
import 'package:agrosnap/Services/API.dart';
import 'package:agrosnap/Services/PositionOnMap.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlantNotifier extends ChangeNotifier{
  List<int> bagOfIndex=[];
  int index = 0;
  bool loading = true;
  List<PlantInfo> plants = [];
  List<StoreOwner> stores = [];
  var plant;
  List<String> info = [
    "نظرة عامة","طرق الزراعة","عوامل تساعد على النمو","الأنواع الأنسب للزراعة المنزلية",
    "الحصاد","الري","كيفية استخلاص البذور وتهيئتها للزراعة","الأوقات الأنسب للزراعة",
    "خصائص التربة","أسمدة تحفز النمو","الأمراض التي تصيب النبات","نصائح للعناية بالنبات"
  ];
  List<String> scientificInfo = [
    "الأسم العلمي","النطاق","المملكة","الفرقة العليا","القسم","الشعبة","العمارة","الرتبة",
    "الرتبة العليا","الفصيلة","الأسرة","العائلة","القبيلة","الجنس","النوع"
  ];
  List<String> disease = [
    "نظرة عامة ","محفزات المرض ","المعالجة الكيميائية","المعالجة العضوية ","طرق الوقاية",
    "المحاصيل اللتي تصاب به","الأعراض"
  ];

  bool get getEmptyBagOfIndex => bagOfIndex.isEmpty;

  void setBagOfIndex({required int index}){
    if(bagOfIndex.contains(index))
      bagOfIndex.remove(index);
    else
      bagOfIndex.add(index);
    notifyListeners();
  }

  void updateIndex({required int uIndex}){
    index = uIndex;
    notifyListeners();
  }

  void setLoading(){loading=true;}

  void setPlant({required recommendedPlant}) {plant = recommendedPlant;}

  void getAllPlants({required bool dark,required bool arabic}) async{
    final response = await API.getAllPlants();
    if(response == false || response == null)
      General.buildToast(msg: (arabic)?"تحقق من اتصالك بالإنترنت":"check your internet connection", dark: dark);
    else
      plants = response;
    loading = false;
    notifyListeners();
  }

  void getSearchedPlants({required bool dark,required bool arabic,required String search}) async{
    loading = true;
    notifyListeners();
    final response = await API.getSearchedPlants(search: search);
    if(response == false || response == null)
      General.buildToast(msg: (arabic)?"تحقق من اتصالك بالإنترنت":"check your internet connection", dark: dark);
    else
      plants = response;
    loading = false;
    notifyListeners();
  }

  void getPlantInfo({required String id,required bool dark,required bool arabic}) async{
    final response = await API.getPlant(id:id);
    if(response == false || response == null)
      General.buildToast(msg: (arabic)?"تحقق من اتصالك بالإنترنت":"check your internet connection", dark: dark);
    else
      plant = response;
    loading = false;
    notifyListeners();
  }

  void getStoresWithPlant({required bool dark,required bool arabic,required String name}) async{
    LatLng latLng = await PositionOnMap.getCurrentPosition();
    final response = await API.location(name: name,lat: latLng.latitude,long: latLng.longitude);
    if(response == false || response == null)
      General.buildToast(msg: (arabic)?"تحقق من اتصالك بالإنترنت":"check your internet connection", dark: dark);
    else
      stores = response;
    print(stores);
    loading = false;
    notifyListeners();
  }
}