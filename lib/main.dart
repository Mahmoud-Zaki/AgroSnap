import 'package:agrosnap/Provider/AdviceAndArticleNotifier.dart';
import 'package:agrosnap/Provider/AuthNotifier.dart';
import 'package:agrosnap/Provider/MapNotifier.dart';
import 'package:agrosnap/Provider/NavigationNotifier.dart';
import 'package:agrosnap/Provider/PlantNotifier.dart';
import 'package:agrosnap/Provider/RemindersNotififier.dart';
import 'package:agrosnap/Provider/SearchNotifier.dart';
import 'package:agrosnap/Provider/SettingNotifier.dart';
import 'package:agrosnap/Provider/StorePageNotifier.dart';
import 'package:agrosnap/Screens/Home/Home.dart';
import 'package:agrosnap/Screens/Introduction/Introduction.dart';
import 'package:agrosnap/Services/SharedPreference.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GestureBinding.instance.resamplingEnabled = true;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? sawIntro = true;

  @override
  void initState() {
    _start();
    super.initState();
  }

  void _start() async{
    final bool _sawIntro = await SharedPreferenceHandler.getSawIntro()??false;
    setState(() {
      sawIntro = _sawIntro;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingNotifier()),
        ChangeNotifierProvider(create: (_) => NavigationNotifier()),
        ChangeNotifierProvider(create: (_) => RemindersNotifier()),
        ChangeNotifierProvider(create: (_) => StorePageNotifier()),
        ChangeNotifierProvider(create: (_) => MapNotifier()),
        ChangeNotifierProvider(create: (_) => PlantNotifier()),
        ChangeNotifierProvider(create: (_) => AdviceAndArticleNotifier()),
        ChangeNotifierProvider(create: (_) => SearchNotifier()),
        ChangeNotifierProvider(create: (_) => AuthNotifier())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AgroSnap',
        color: Constants.primaryColor,
        home: (sawIntro!)?Selector<SettingNotifier,bool>(
          selector: (context,language)=>language.getArLanguage,
          builder: (context,arabic,child){
            Provider.of<SettingNotifier>(context,listen: false).getData();
            return Directionality(
              textDirection: (arabic) ? TextDirection.rtl : TextDirection.ltr,
              child:
              Selector<SettingNotifier,bool>(
                selector: (context,setting)=>setting.dark,
                builder: (context,dark,child){
                  return Home(dark: dark);
                }
              ) // Recommended(arabic: arabic, dark: dark) //Plant(arabic: arabic)
            );
          },
        ) : Introduction(),
      ),
    );
  }
}