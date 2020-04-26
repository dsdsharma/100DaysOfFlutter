import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


//this is a helper class used to load the json and translate it to map.
class DemoLocalization{
  DemoLocalization(this.locale);

  final Locale locale;
  static DemoLocalization of(BuildContext context){
    return Localizations.of<DemoLocalization>(context, DemoLocalization);
  }
  Map<String,String> _localizedValues;
  //load the language package from json to app
  Future<bool> load()async{
    //get values from json file
    String jsonStringValues = 
    await rootBundle.loadString('lib/lang/${locale.languageCode}.json');
    //parsed json into map of string and dynamic
    Map<String,dynamic> mappedJson = json.decode(jsonStringValues);

    //converted dynamic values to string
    _localizedValues = mappedJson.map((key, value) => MapEntry(key,value.toString()));

    return true;

  }
  //get value from key
  String translate(String key){
    return _localizedValues[key];
  }
  // static member to have access to delegate from material app
  static const LocalizationsDelegate<DemoLocalization> delegate = _DemoLocalizationsDelegate();

}
class _DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalization>{
  const _DemoLocalizationsDelegate();
  //check if app language code matches with json versions
  @override
  bool isSupported(Locale locale) {
    return ['en','hi'].contains(locale.languageCode);
  }
  @override
  Future<DemoLocalization> load(Locale locale)async{
    DemoLocalization localization = new DemoLocalization(locale);
    await localization.load();
    return localization;
  }
  @override
  bool shouldReload(LocalizationsDelegate<DemoLocalization> old)=> false;
}
