import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_register/models/user.dart';
import 'package:flutter_login_register/pages/homeAdm/homeAdm.dart';
import 'package:flutter_login_register/pages/homeUser/home_page.dart';
import 'package:flutter_login_register/pages/login/login_presenter.dart';
import 'package:flutter_login_register/pages/login/triangle_painter.dart';
import 'package:flutter_login_register/welcome.dart';

class LoginPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: constraints.maxHeight,
                  minHeight: constraints.maxHeight,
                ),
                child: LoginPage(),
              ),
            ),
          );
        },
      ),
      
    );
  }
}

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin implements LoginPageContract {

  var _loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _username, _password,_error;
  
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  PageController _pageController;
   bool _obscurePassword = true;

  LoginPagePresenter _presenter;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    resetFields();
  }
  void resetFields() {
    _emailController.text = '';
    _passwordController.text = '';
    _cadastrando(enable: false);
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  _LoginPageState() {
    _presenter = new LoginPagePresenter(this);
  }

  Future _submit() async {
    _cadastrando(enable: true);
    if (_formKey.currentState.validate()) {
     _formKey.currentState.save();
        _loading = true;
        _presenter.doLogin(_username, _password);
    }
  }

 void showFlushBar(BuildContext context) {
    Flushbar(
      title: 'Erro encontrado',
      message: 'E-mail ou senha inválido!',
      icon: Icon(
        Icons.info_outline,
        size: 28,
        color: Colors.blue.shade400,
      ),
      duration: Duration(seconds: 3),
    )..show(context);
  }

  void _toggleObscurePassword(){
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context){ 
    return new Scaffold(
      body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildHeaderPanel(context),
              _buildMenuBar(context),
              Expanded(
                flex: 1,
                child: PageView(
                  controller: _pageController,
                ),
              ),
              SizedBox(
                height: 26.0,
              ),
              
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: 340.0,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (val) {
                      if (val.isEmpty) {
                        _cadastrando(enable: false);
                        return 'Por favor entre com um e-mail valido';
                      }
                    },
                    
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: 'E-mail*', hintStyle: TextStyle(fontSize: 16),
                    ),
                    onSaved: (val) => _username = val,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: 340.0,
                  child: TextFormField(
                    controller: _passwordController,
                    validator: (val) {
                      if (val.length < 6) {
                         _cadastrando(enable: false);
                        return 'Necessário senha maior que 6 caracteres';
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                     icon:
                             Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                       onPressed: _toggleObscurePassword,
                       ),
                      icon: Icon(Icons.security),
                      hintText: 'Senha*',hintStyle: TextStyle(fontSize: 16),
                      
                    ),
                    onSaved: (val) => _password = val,
                    obscureText: _obscurePassword,

                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              RaisedButton(
                onPressed: _submit,
                child: _loading
                    ? _showLoading()
                    : Text('Login',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                color: Color(0xFFBDA778),
                padding:
                    const EdgeInsets.symmetric(horizontal: 66.0, vertical: 11),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 26.4)),
            ],
          )),
    );
  }

  Widget _buildHeaderPanel(BuildContext context) {
    return Expanded(
      flex: 10,
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Image.asset(
            'assets/images/doctor.jpg',
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Image.network(
                    "http://icons.iconarchive.com/icons/medicalwp/medical/256/Doctor-Briefcase-blue-icon.png",
                    color: Colors.white,
                    width: 100.0,
                    height: 100.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                    child: Text(
                      "",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 1.0,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      height: 60.0,
      color: Color(0xFFBDA778),
      child: CustomPaint(
        painter: TrianglePainter(_pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(height: 33.0, width: 1.0, color: Colors.white),
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WelcomePage()));
                });
              },
            ),
            Expanded(
              child: FlatButton(
                onPressed: () {
                  resetFields();
                },
                child: Text(
                  "Seja Bem-Vindo!            ",
                  style: TextStyle(color: Colors.white, fontSize: 18.3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showLoading() {
    return Container(
      width: 17.0,
      height: 17.0,
      child: CircularProgressIndicator(backgroundColor: Colors.blue,) ,
    );
  }

  void _cadastrando({bool enable}) {
    setState(() {
      _loading = enable;
    });
  }

  
  void onLoginError(String error) {
    _loading = true;
    Future.delayed(const Duration(seconds: 3),
    () =>setState(
      (){
        showFlushBar(context);
        _loading = false;
      }
    ),
    );
    
  }

  Future onLoginSuccess(User user) async {
    _cadastrando(enable: true);
    try{
      if(_username == "adm@gmail.com" && _password == "Admin123"){
        Future.delayed(const Duration(seconds: 3),
        ()=> setState(
          () { 
         Navigator.push( context, MaterialPageRoute(builder: (context) => Home()));
          },
        ),
        );
          
      }
      else if(user == user){
        Future.delayed(const Duration(seconds: 3),
        ()=> setState(
          () { 
         Navigator.push( context, MaterialPageRoute(builder: (context) => Homeuser()));
          },
        ),
        );
      }
    }catch(e){
         _error = e.message;
          showFlushBar(context);
          _cadastrando(enable: false);
          _loading = false;
    }
  }
}
