import 'package:flutter/material.dart';

class Constants {
  static const String baseURL = "";

  static const Color primaryColor = Color(0xff496973);
  static const Color secondaryColor = Color(0xff5C808B);
  static const Color petrolColor = Color(0xff174D5A);
  static const Color blueGray = Color(0xff71848A);
  static const Color grayLight = Color(0xffb9c5c9);
  static const Color darkGrayLight = Color(0xff4B4B4B);
  static const Color gray = Color(0xff455c63);
  static const Color blueLight = Color(0xffe4ecef);
  static const Color darkBlueLight = Color(0xff2C2C2C);
  static const Color halfBlue = Color(0xffBECFD4);
  static const Color blue = Color(0xff96b7c0);
  static const Color facebookColor = Color(0xffa1b7bc);
  static const Color darkFacebookColor = Color(0xff5B9FAE);
  static const Color phoneColor = Color(0xff9eae9b);
  static const Color darkPhoneColor = Color(0xff85BE7B);
  static const Color primaryColorGrading = Color(0xff9fbfc4);
  static const Color whiteTopGrading = Color(0xffdde5e8);
  static const Color halfGray = Color(0xff8aa0a7);
  static const Color loopColor = Color(0xff94bcc7);
  static const Color darkLoop = Color(0xff5B838F);
  static const Color darkLoopGrading = Color(0xff273B3E);
  static const Color blueGreen = Color(0xffa8e0b8);
  static const Color orange = Color(0xffffb975);
  static const Color darkOrange = Color(0xffFABA7A);
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  static const Map<String,String> translate = {
    "تسجيل جديد": "Register",
    "تسجيل الدخول": "Login",
    "البريد الإلكتروني": "E-mail",
    "كلمة المرور": "Password",
    "اسم المتجر": "Store Name",
    "الدخول": "Enter",
    "تسجيل": "Sign Up",
    "هل لديك حساب بالفعل؟": "Do you already have an account?",
    "بحث عن النباتات": "Search for plants",
    "تذكير": "Reminder",
    "اليوم": "Today",
    "لا يوجد تذكير": "No Reminder",
    "مقالات": "Articles",
    "نصائح": "Advices",
    "التذكير برعاية النبات": "Plant Care Reminder",
    "إضافة تذكير جديد": "Add a new Reminder",
    "المتاجر": "Stores",
    "بحث عن متاجر": "Search for Stores",
    "الإعدادات": "Settings",
    "الوضع الليلي": "Night Mode",
    "حجم الخط": "Font Size",
    "اللغة": "Language",
    "مشاركة التطبيق": "Share App",
    "عادي": "Normal",
    "كبير": "Big",
    "En": "En",
    "ع": "Ar",
    "تذكير جديد": "New Reminder",
    "التكرار": "Repeat",
    "الري": "Water",
    "التسميد": "Fertilizer",
    "الحصاد": "Harvest",
    "ري النبات": "Water",
    "تسميد النبات": "Fertilizer",
    "حصاد النبات": "Harvest",
    "اخرى": "Other",
    "حفظ": "Save",
    "إعادة ضبط التذكير":"Reset Reminder",
    "حذف النبات":"Delete Plant",
    "يوم":"Day",
    "أسبوع":"Week",
    "شهر":"Month",
    "سنة":"Year",
    "كل":"Every",
    "حذف تذكير":"Delete Reminder",
    "هل تريد حذف التذكير؟":"Do you want to delete the reminder?",
    "إلغاء":"Cancel",
    "حذف":"Delete",
    "ضبط الحساب":"Account settings",
    "تسجيل الخروج":"Log out",
    "حذف الحساب":"Delete account",
    "إضافة نبات جديد":"Add New Plant",
    "إضافة":"Add",
    "تعديل":"Update",
    "إضافة علامة":"Add Marker",
    "ابحث عن مكان":"Search for Place",
    "أضف إلى الرعاية":"Add to Care",
    "اختر":"Choose",
    "تحديث صورة الملف الشخصي":"Update Profile Image",
    "تحديث":"Update"
  };

  static double getScreenHeight(context){
    return MediaQuery.of(context).size.height;
  }
  static double getScreenWidth(context){
    return MediaQuery.of(context).size.width;
  }
}
