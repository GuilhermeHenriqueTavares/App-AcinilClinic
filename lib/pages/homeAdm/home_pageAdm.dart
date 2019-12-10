import 'package:flutter/material.dart';
import 'package:flutter_login_register/data/database_helper.dart';
import 'package:flutter_login_register/models/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => new DynamicList();
}

class DynamicList extends State<HomePage> {
  List<User> users;
  List<User> id;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 18.5);

  void _showAlertDialog(
      {String tittle, String content, Function onCancel, Function onConfirm}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(tittle),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Cancelar',
                  style: TextStyle(fontSize: 17),
                ),
                onPressed: () {
                  if (onCancel != null) onCancel();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  'Confirmar',
                  style: TextStyle(fontSize: 17),
                ),
                onPressed: () {
                  if (onConfirm != null) onConfirm();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Usuários Cadastrados',
            style: TextStyle(fontSize: 18.9, color: Colors.white),
          ),
        ),
        body: new ListView.builder(
            itemCount: users.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return singleRow(users[index], users[index]);
            }));
  }

  @override
  void initState() {
    super.initState();
    var db = new DatabaseHelper();
    db.getAllUser().then((user) {
      users = user;
      print(users);
      setState(() {});
    });
    var db2 = new DatabaseHelper();
    db2.getAllUser().then((id) {
      users = id;
    });
  }

  Widget singleRow(User user, User id) {
    return new Container(
        padding: EdgeInsets.all(5),
        child: Row(children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Text(
                'ID: ' +
                    user.id.toString() +
                    '  ' +
                    'E-mail:  ' +
                    user.username,
                style: TextStyle(
                  fontSize: 15.7,
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
             Container(
           decoration: BoxDecoration(
             border: Border(
               bottom: BorderSide(color: Colors.black,width: 2.0,),
             ),
           ),
         ) 
            ],
          )),
          IconButton(
              icon: Icon(
                FontAwesomeIcons.solidTrashAlt,
                color: Colors.red[500],
              ),
              onPressed: () {
                _showAlertDialog(
                  tittle: 'Alerta!',
                  content: 'Tem certeza que deseja excluir?',
                  onConfirm: () {
                    setState(() {
                      _delete(user);
                    });
                  Navigator.of(context).pop();
                  },
                  onCancel: () {
                    setState(() {});
                  },
                );
                print(user.id.toString() + ' ' + user.username);
              }),
        ]));
  }

  void _delete(User user) {
    var db = new DatabaseHelper();
    db.deleteSingleUser(user.id).then((id) {
      print('Usuário removido com sucesso');
      users.remove(user);
      setState(() {});
    });
  }
}
