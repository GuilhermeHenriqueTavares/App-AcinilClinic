
import 'package:flutter/material.dart';
import 'package:flutter_login_register/pages/homeUser/google.dart';
import 'pages/login/login_page.dart';
import 'pages/register/register_page.dart';
import 'package:flutter_login_register/services/FBApi.dart';

class WelcomePage extends StatefulWidget {

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   bool _isLoading = false;

  Future<bool> _loginUser() async {
    final api = await FBApi.signInWithGoogle();
    if (api != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Acinil Clinic',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: <Widget>[
          Image.asset('assets/images/Manhattan.png',
              height: 290, alignment: Alignment.topCenter),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    splashColor: Colors.blueGrey,
                    color: Color(0xFFBDA778),
                    child: new Row(
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "         ENTRAR",
                            style: TextStyle(color: Colors.white, fontSize: 19),
                          ),
                        ),
                        new Expanded(
                          child: Container(),
                        ),
                        new Transform.translate(
                          offset: Offset(15.0, 0.0),
                          child: new Container(
                            padding: const EdgeInsets.all(5.0),
                            child: FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(28.0)),
                              splashColor: Colors.white,
                              color: Colors.white,
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                              ),
                              onPressed: () => {
                              Navigator.pushNamed(context, '/login'),
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    onPressed: () => {},
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    splashColor: Colors.blueGrey,
                    color: Color(0xFFBDA778),
                    child: new Row(
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "         CADASTRAR",
                            style: TextStyle(color: Colors.white, fontSize: 19),
                          ),
                        ),
                        new Expanded(
                          child: Container(),
                        ),
                        new Transform.translate(
                          offset: Offset(15.0, 0.0),
                          child: new Container(
                            padding: const EdgeInsets.all(5.0),
                            child: FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(28.0)),
                              splashColor: Colors.white,
                              color: Colors.white,
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                              ),
                              onPressed: () => {
                                Navigator.pushNamed(context, '/register'),
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    onPressed: () => {},
                  ),
                ),
              ],
            ),
          ),
            Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: new Row(
               mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    splashColor: Colors.pink,
                    color: Color(0xFFBDA778),
                    child: new Row(
                      children: <Widget>[
                        
                        Image.asset('assets/images/google.png',width: 32.7,),
                        SizedBox(width:10.0),
                        new Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "LOGIN COM GOOGLE",
                            style: TextStyle(color: Colors.white, fontSize: 19),
                          ),
                        ),
                        new Expanded(
                          child: Container(),
                        ),
                        new Transform.translate(
                          offset: Offset(15.0, 0.0),
                          child: new Container(
                            padding: const EdgeInsets.all(5.0),
                            child: FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(28.0)),
                              splashColor: Colors.white,
                              color: Colors.white,
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                              ),
                              onPressed: () async {
                  setState(() => _isLoading = true);
                  bool b = await _loginUser();
                  setState(() => _isLoading = false);
                  if (b == true) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) {
                      return new Google();
                    }));
                  } else {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Wrong email or")));
                  }
                },
                            ),
                          ),
                        )
                      ],
                    ),
                    onPressed: (){},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
