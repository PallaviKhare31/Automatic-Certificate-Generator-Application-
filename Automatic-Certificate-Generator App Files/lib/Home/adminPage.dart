import 'package:certificate/Home/PDFCreator.dart';
import 'package:certificate/Home/inputField.dart';
import 'package:certificate/Login/Start.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  bool isloggedin = false;

  late TextEditingController _name;
  late TextEditingController _rank;

  late FocusNode _nameFocus;
  late FocusNode _rankFocus;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _rank = TextEditingController();

    _nameFocus = FocusNode();
    _rankFocus = FocusNode();
  }

  void fieldUnfocus() {
    _nameFocus.unfocus();
    _rankFocus.unfocus();
  }

  @override
  void dispose() {
    super.dispose();
    _nameFocus.dispose();
    _rankFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 40.0),
            Container(
              height: 300,
              child: Image(
                image: AssetImage("images/welcome.jpg"),
                fit: BoxFit.contain,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InputField(
                    label: 'Name...',
                    controller: _name,
                    focusNode: _nameFocus,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InputField(
                    label: 'Rank...',
                    controller: _rank,
                    focusNode: _rankFocus,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                  onPressed: () {
                    PDFCreator().createPDF(_name.text, _rank.text);
                  },
                  child: Text('Get Certificate',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Start()));
                  },
                  child: Text('HOME',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
