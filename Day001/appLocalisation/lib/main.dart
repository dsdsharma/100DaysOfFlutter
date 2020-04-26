import 'package:flutter/material.dart';
import 'package:appLocalisation/localization/demo_localization.dart';
import 'package:appLocalisation/router/custom_router.dart';
import 'package:appLocalisation/router/route_constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'localization/language_constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (this._locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800])),
        ),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Flutter Localization Demo",
        theme: ThemeData(primarySwatch: Colors.blue),
        locale: _locale,
        supportedLocales: [
          Locale("en", "US"),
          Locale("hi", "IN")
        ],
        localizationsDelegates: [
          DemoLocalization.delegate,//local language properties handeler
          GlobalMaterialLocalizations.delegate,//it changes text all around app
          GlobalWidgetsLocalizations.delegate,//it changes left to right/right to left writin system
          GlobalCupertinoLocalizations.delegate,// for cupertino based app
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        onGenerateRoute: CustomRouter.generatedRoute,
        initialRoute: homeRoute,
      );
    }
  }
}