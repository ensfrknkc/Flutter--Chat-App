import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kbu_app/localization/demoLocalization.dart';
import 'package:kbu_app/services/locator.dart';
import 'package:kbu_app/view_model/user_viewModel.dart';
import 'package:provider/provider.dart';
import 'localization/localization_constants.dart';
import 'screens/signIn/landing_page.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  State<StatefulWidget> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp>{
    Locale _locale;
    void setLocale(Locale locale) {
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
      if(_locale == null){
        return Container(child: Center(child: CircularProgressIndicator(),),);
      }
      else{
        return ChangeNotifierProvider(
          builder:(context)=> UserViewModel(),
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Unicapp',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              locale: _locale,
              supportedLocales: [
                Locale('tr','TR'),
                Locale('en','US'),
                Locale('ar','SA'),
              ],
              localizationsDelegates:[
                DemoLocalization.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ] ,
              localeResolutionCallback: (deviceLocale,supportedLocales){
                for(var locale in supportedLocales){
                  if(locale.languageCode == deviceLocale.languageCode && locale.countryCode == deviceLocale.countryCode){
                    return locale;
                  }
                }
                return supportedLocales.first;
              },
              home:LandingPage()),
        );
      }
    }

}
