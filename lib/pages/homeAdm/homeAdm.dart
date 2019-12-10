import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register/pages/homeAdm/addUser.dart';
import 'package:flutter_login_register/pages/homeAdm/home_pageAdm.dart';
import 'package:flutter_login_register/welcome.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_login_register/data/database_helper.dart';
import 'package:flutter_login_register/models/user.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<User> users;
    var db = new DatabaseHelper();
    db.getAllUser().then((user){
      users = user;
      print(users);
      
    });

  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }
    return Scaffold( 
      
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Bem-Vindo Administrador ', style: TextStyle(fontSize: 16.9, color: Colors.white), ),
        
      ),
      drawer: Drawer(
        
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              
              accountName: Text(''),
              accountEmail: Text('User atual '),
              currentAccountPicture: CircleAvatar(
                child: Text('Administrador'.toUpperCase()[0],style: TextStyle(fontSize: 30),),
              ),
              otherAccountsPictures: <Widget>[
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Adicionando nova conta...'),
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
                  child: IconButton(icon: 
                  Icon(FontAwesomeIcons.lightbulb,color: Colors.black,),
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
                  Navigator.push( context, MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: ListTile(
              leading: Icon(FontAwesomeIcons.users, color: Color(0xFFBDA778)),
              title: Text('Usuários',style: TextStyle(fontSize: 17)),
            ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push( context, MaterialPageRoute(builder: (context) => AddUser()));
              },
              child: ListTile(
              leading: Icon(FontAwesomeIcons.userPlus, color: Color(0xFFBDA778)),
              title: Text('Cadastrar usuário',style: TextStyle(fontSize: 17)),
            ),
            ),
            Divider(color: Colors.black54,),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.signOutAlt, color: Color(0xFFBDA778)),
                  title: Text('Logout',style: TextStyle(fontSize: 17)),
                  onTap: (){
                    Navigator.push( context, MaterialPageRoute(builder: (context) => WelcomePage()));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  }
