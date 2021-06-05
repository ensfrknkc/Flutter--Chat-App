import 'package:flutter/material.dart';
import 'package:kbu_app/localization/demoLocalization.dart';
import 'package:shared_preferences/shared_preferences.dart';

String getTranslated(BuildContext context,String key){
  return DemoLocalization.of(context).getTranslatedValue(key);
}

const String LANGUAGE_CODE = 'languageCode';
String languageCodeGlobal;

const String ENGLISH = 'en';
const String TURKISH = 'tr';
const String ARABIC = 'ar';

Future<Locale> setLocale(String languageCode) async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LANGUAGE_CODE, languageCode);

  return _locale(languageCode);
}

Locale _locale(String languageCode){
  Locale _temp;
  switch(languageCode){
    case ENGLISH:
      _temp = Locale(languageCode,'US');
      break;
    case TURKISH:
      _temp = Locale(languageCode,'TR');
      break;
    case ARABIC:
      _temp = Locale(languageCode,'SA');
      break;
    default:
      _temp = Locale(languageCode,'TR');
  }

  return _temp;
}

Future<Locale> getLocale() async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LANGUAGE_CODE) ?? "TR";
  languageCodeGlobal = languageCode;
  return _locale(languageCode);}


