import 'package:flutter/material.dart';
import 'package:flutter_login_register/models/user.dart';
import 'package:flutter_login_register/pages/homeUser/chatbot.dart';
import 'package:flutter_login_register/pages/homeUser/map.dart';
import 'package:flutter_login_register/pages/homeUser/sendMail.dart';
import 'package:flutter_login_register/welcome.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter_login_register/data/database_helper.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class Homeuser extends StatelessWidget {

  static var dados = DatabaseHelper();
  static var usuario  = User;

  final pages = [
    PageViewModel(
        pageColor: const Color(09934),
        // iconImageAssetPath: 'assets/air-hostess.png',
        bubble: Image.asset('assets/air-hostess.png'),
        body: Text(
          'Em construção',
        ),
        title: Text(
          'Em Construção',
        ),
        titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.black),
        bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.black),
        mainImage: Image.asset(
          'assets/airplane.png',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
    PageViewModel(
      pageColor: const Color.fromRGBO(77, 77, 77,1),
      iconImageAssetPath: 'assets/waiter.png',
      body: Text(
        'Em construção',
      ),
      title: Text('Em construção'),
      mainImage: Image.asset(
        'assets/hotel.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
    PageViewModel(
      pageColor: const Color.fromRGBO(0, 0, 153,0.86),
      iconImageAssetPath: 'assets/taxi-driver.png',
      body: Text(
        'Em construção',
      ),
      title: Text('Em construção'),
      mainImage: Image.asset(
        'assets/taxi.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
  ];


  @override
  Widget build(BuildContext context) {
    print(dados);
  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Bem-Vindo usuário '  , style: TextStyle(fontSize: 16.9, color: Colors.white), ),
      ),
      body: Builder(
        builder:(context) => IntroViewsFlutter(
          pages,
          showNextButton: false,
          showBackButton: false,
          showSkipButton: false,
          doneText:Container(
            height: 25,
            width: 25,
            child: CircleAvatar(backgroundImage:
             NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHDPoRrBbcuKx69212zeqZ39ft6nZmL7BdhZcu-rlVEMcd_QO8&s')
             ),
             ),
          onTapDoneButton: (){
           return null;
          },
          doneButtonPersist: false,
          pageButtonTextStyles: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text('chamar o user', style: TextStyle(fontSize: 18),),
              accountEmail: Text('chamar o email cadastrado',style: TextStyle(fontSize: 15),),
              currentAccountPicture: CircleAvatar( child: Text(usuario.toString().toUpperCase()[0], style: TextStyle(fontSize: 30),),),
              otherAccountsPictures: <Widget>[
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Adicionando imagem...'),
                          );
                        });
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white30,
                    child: Icon(Icons.add, color: Colors.black,),
                  ),
                ),
                GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.white30,
                  child: IconButton(
                 icon: Icon( Theme.of(context).brightness == Brightness.light ? FontAwesomeIcons.lightbulb : FontAwesomeIcons.solidLightbulb,color: Colors.black),
                  onPressed: (){
                      changeBrightness();
                  },
                  ),
                  ),
                ),
              ],
            ),
            
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            GestureDetector(
              onTap: (){
                  Navigator.of(context).pop();
              },
           child: ListTile(
              leading: Icon(FontAwesomeIcons.home,color: Color(0xFFBDA778)),
              title: Text('Página principal',style: TextStyle(fontSize: 17)),
            ),
            ),
            GestureDetector(
            onTap: (){
              Navigator.push( context, MaterialPageRoute(builder: (context) => Mapa()));
            },
           child: ListTile(
              leading: Icon(FontAwesomeIcons.mapMarkerAlt, color: Color(0xFFBDA778)),
              title: Text('Localizar Clínicas/Hospitais',style: TextStyle(fontSize: 17)),
            ),
            ),
            GestureDetector(
              onTap: (){
                 Navigator.push( context, MaterialPageRoute(builder: (context) => SendMail()));
              },
           child: ListTile(
              leading: Icon(FontAwesomeIcons.calendarAlt, color: Color(0xFFBDA778)),
              title: Text('Agendar Consulta',style: TextStyle(fontSize: 17)),
            ),
            ),
            GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Chatbot()));
            },
           child: ListTile(
              leading: Icon(FontAwesomeIcons.facebookMessenger, color: Color(0xFFBDA778)),
              title: Text('HealthBot',style: TextStyle(fontSize: 17)),
            ),
            ),
            Divider(),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.signOutAlt, color: Color(0xFFBDA778)),
                  title: Text('Logout',style: TextStyle(fontSize: 17)),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage()));
                  }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}