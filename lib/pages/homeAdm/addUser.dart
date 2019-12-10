import 'package:flutter/material.dart';
import 'package:flutter_login_register/data/database_helper.dart';
import 'package:flutter_login_register/models/user.dart';
import 'package:flutter_login_register/pages/register/register_presenter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> implements RegisterPageContract{
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  RegisterPagePresenter _presenter;
  var _loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _username, _password;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 18.5);

  void resetFields() {
    _emailController.text = '';
    _passwordController.text = '';
    _cadastrando(enable: false);
  }

 

  _AddUserState(){
    _presenter = new RegisterPagePresenter(this);
  }

  Widget _showLoading() {
    return Container(
      width: 15.0,
      height: 15.0,
      child: CircularProgressIndicator(backgroundColor: Colors.red,),
    );
  }

  void _cadastrando({bool enable}) {
    setState(() {
      _loading = enable;
    });
  }

  Future _submit() async {
    _cadastrando(enable: true);
    final form = _formKey.currentState;

    if (form.validate()) {
      setState(() {
        _loading = true;
        form.save();
        _presenter.doRegister(_username, _password);
      });
    }
    else{
      setState(() {
       _cadastrando(enable: true); 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[

        Builder(builder: (BuildContext context){
          return IconButton(
            onPressed: (){
                resetFields();
            },
            icon: Icon(FontAwesomeIcons.redoAlt),
          );
        },)
          
          ],
        title: Text(
          'Cadastrar usuários',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
      ),
      //resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Center(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset('assets/images/addUser.png'),
                    ),
                  ),
              SizedBox(
                height: 80,
              ),
              SizedBox(
                width: 340,
                child:TextFormField(
                controller: _emailController,
                validator: (input) {
                      if (input.isEmpty) {
                        return 'Por favor entre com um e-mail valido';
                      }
                    },
                style: style,
                onSaved: (input) => _username = input,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 340,
              child: TextFormField(
                controller: _passwordController,
                validator: (input) {
                      if (input.length < 6) {
                        return 'Necessário senha maior que 6 caracteres';
                      }
                    },
                obscureText: true,
                style: style,
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Senha",
                    
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              ),
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                onPressed: _submit,
                child: _loading
                    ? _showLoading()
                    : Text('Cadastrar',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                color: Color(0xFFBDA778),
                padding:
                    const EdgeInsets.symmetric(horizontal: 66.0, vertical: 11),
              ),
            ],
          ),
        
        ),
      
      ),
    );
  }

@override
  void onRegisterError(String error) {
    setState(() {
      _loading = false;
    });
  }

  @override
  void onRegisterSuccess(User user) async {
    setState(() {
      _loading = false;
    });
    var db = new DatabaseHelper();
    await db.saveUser(user);
    print('Usuário incluido com sucesso!');
    Navigator.of(context).pop();
  }
}
