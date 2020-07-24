import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:video_call_app/resources/firebase_repository.dart';
import 'package:video_call_app/screens/homeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseRepository _repository = FirebaseRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 70.0, left: 20.0, right: 20.0),
          child: Column(
            children: <Widget>[
              Text(
                "Best Video call app",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(child: loginButton())
            ],
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    return FloatingActionButton(
      child: Icon(Icons.arrow_forward_ios),
      elevation: 10.0,
      onPressed: () => performLogin(),
    );
  }

  void performLogin() {
    print("tring to perform login");
    _repository.signIn().then((FirebaseUser user) {
      print("something");
      if (user != null) {
        authenticateUser(user);
      } else {
        print("There was an error");
      }
    });
  }

  void authenticateUser(FirebaseUser user) {
    _repository.authenticateUser(user).then((isNewUser) {
      if (isNewUser) {
        _repository.addDataToDb(user).then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }));
        });
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      }
    });
  }
}
