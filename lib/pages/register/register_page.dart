import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_register/data/database_helper.dart';
import 'package:flutter_login_register/models/user.dart';
import 'package:flutter_login_register/pages/login/triangle_painter.dart';
import 'package:flutter_login_register/pages/register/register_presenter.dart';
import 'package:flutter_login_register/welcome.dart';

class RegisterBody extends StatelessWidget {
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
                child: RegisterPage(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> implements RegisterPageContract {
  var _loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _username, _password,_error;
  
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  PageController _pageController;

  RegisterPagePresenter _presenter;

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

  _RegisterPageState() {
    _presenter = new RegisterPagePresenter(this);
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Form(
          key: _formKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
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
              Padding(padding: EdgeInsets.symmetric(vertical: 1)),
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: 340.0,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (input) {
                      if (input.isEmpty) {
                        Future.delayed(const Duration(seconds: 1),
                        ()=>setState(
                          (){
                             _cadastrando(enable: false);
                          }
                        ),
                        );
                        return 'Por favor entre com um e-mail valido';
                      }
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: 'E-mail*',hintStyle: TextStyle(fontSize: 16),
                    ),
                    onSaved: (input) => _username = input,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: 340.0,
                  child: TextFormField(
                    controller: _passwordController,
                    validator: (input) {
                      if (input.length < 6) {
                        Future.delayed(const Duration(seconds: 1),
                        ()=>setState(
                          (){
                             _cadastrando(enable: false);
                          }
                        ),
                        );
                        return 'Necessário senha maior que 6 caracteres';
                      }
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.security),
                      hintText: 'Senha*',hintStyle: TextStyle(fontSize: 16),
                    ),
                    onSaved: (input) => _password = input,
                    obscureText: true,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
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
              FlatButton(
                onPressed: () {
                   Navigator.of(context).pushNamed("/login");
                },
                child: Text(
                  "Já possui um cadastro?",
                  style: TextStyle(color: Colors.black54, fontSize: 17),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10.4)),
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
                  "Cadastre-se Já             ",
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
      child: CircularProgressIndicator(backgroundColor: Colors.blue,),
    );
  }

  void _cadastrando({bool enable}) {
    setState(() {
      _loading = enable;
    });
  }

  @override
  void onRegisterError(String error) {
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

  @override
  void onRegisterSuccess(User user) async {
    setState(() {
      _loading = true;
    });
    var db = new DatabaseHelper();
    await db.saveUser(user);
    Future.delayed(const Duration(seconds: 2),
    ()=> setState(
      (){
        _loading = false;
         Future.delayed(const Duration(milliseconds: 500),
         ()=> setState(
           (){
              Navigator.of(context).pushNamed("/login");
           }
         ),
         );
      }
    ),
    );
   
  }
}
