import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:intl/intl.dart';

class SendMail extends StatefulWidget {
  @override
  _SendMailState createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> with SingleTickerProviderStateMixin {
  String attachment;
  DateTime _date = DateTime.now();
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  TimeOfDay _time = TimeOfDay.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2019),
      lastDate: DateTime(2021),
    );

    if (picked != null && picked != _date) {
      print('data selecionada: ${_date.toString()}');
      setState(() {
        _date = picked;
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _time);

    if (picked != null && picked != _time) {
      print('horario selecionado: ${_time.toString()}');
      setState(() {
        _time = picked;
      });
    }
  }

  final TextEditingController _recipientController = TextEditingController(
    text: 'acinilclinic@gmail.com',
  );

  final TextEditingController _subjectController = TextEditingController();

  final TextEditingController _bodyController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> send() async {
    final Email email = Email(
      body: _bodyController.text +
          '\n\nData: \n' +
          dateFormat.format(_date) +
          '\n\nHorário: \n' +
          _time.format(context).toString(),
      subject: _subjectController.text,
      recipients: [_recipientController.text],
      attachmentPath: attachment,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Agendamento',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            color: Colors.black,
            onPressed: send,
            icon: Icon(Icons.send),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    enabled: false,
                    controller: _recipientController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Recebedor',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _subjectController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Título',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _bodyController,
                    maxLines: 10,
                    decoration: InputDecoration(
                      labelText: 'Assunto',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 230),
                  child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        "Data: ${dateFormat.format(_date)}",
                        style: TextStyle(color: Colors.red),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 1, right: 235),
                  child: RaisedButton(
                    padding: EdgeInsets.only(left: 1, right: 1),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Container(
                      
                      width: 110,
                      height: 50,
                      padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[200],
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Text(
                            '           Data',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 18),
                          ),
                          Container(
                            
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: new AssetImage(
                                    'assets/images/calendar.png'),
                                fit: BoxFit.contain,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 230),
                  child: FlatButton(
                    padding: EdgeInsets.all(15),
                    onPressed: () {},
                    child: Text(
                      "Horário: ${_time.format(context)}",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 1, right: 235),
                  child: RaisedButton(
                    padding: EdgeInsets.only(left: 1, right: 1),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: () {
                      _selectTime(context);
                    },
                    child: Container(
                      width: 110,
                      height: 50,
                      padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[200],
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Text(
                            '           Hora',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                 fontSize: 18),
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: new AssetImage(
                                    'assets/images/clock.png'),
                                fit: BoxFit.contain,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
