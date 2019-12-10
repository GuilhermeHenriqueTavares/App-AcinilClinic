import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register/pages/homeAdm/home_pageAdm.dart';
import 'package:flutter_login_register/pages/register/register_page.dart';
import 'package:flutter_login_register/pages/login/login_page.dart';
import 'package:flutter_login_register/welcome.dart';

void main() => runApp(new MyApp());

final routes = {
  '/login': (BuildContext context) => new LoginPage(),
  '/home': (BuildContext context) => new HomePage(),
  '/register': (BuildContext context) => new RegisterPage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
    defaultBrightness: Brightness.light,
    data: (brightness) => ThemeData(
      primaryColor: Color(0xFFBDA778),
      accentColor: Color(0xFFBDA778),
      brightness: brightness
    ),
    themedWidgetBuilder: (context,theme){
    return new MaterialApp(
      title: 'Projeto',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: WelcomePage(),
      routes: routes,
    );
    });
  }
}
