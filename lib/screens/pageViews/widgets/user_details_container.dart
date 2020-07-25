import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/models/user.dart';
import 'package:video_call_app/provider/user_provider.dart';
import 'package:video_call_app/resources/auth_methods.dart';
import 'package:video_call_app/screens/chatScreens/widgets/cached_image.dart';
import 'package:video_call_app/screens/loginScreen.dart';
import 'package:video_call_app/screens/pageViews/widgets/new_chat_button.dart';
import 'package:video_call_app/widgets/appbar.dart';

class UserDetailsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    signOut() async {
      final bool isLoggedOut = await AuthMethods().signOut();
      if (isLoggedOut) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false);
      }
    }

    return Container(
      margin: EdgeInsets.only(top: 1),
      child: Column(
        children: <Widget>[
          CustomAppBar(
              title: Text("Brand"),
              actions: <Widget>[
                GestureDetector(
                    onTap: () {
                      signOut();
                    },
                    child: LogoutButton())
              ],
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.maybePop(context);
                  }),
              centerTitle: true),
          UserDetailsBody()
        ],
      ),
    );
  }
}

class UserDetailsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final User user = userProvider.getUser;
    final String name = user.name.toString();
    final String photo = user.profilePhoto.toString();
    final String email = user.email.toString();
    final String username = user.username.toString();

    return Container(
      padding: EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CachedImage(
                photo,
                isRound: true,
                radius: 90,
              ),
              SizedBox(
                width: 30,
              ),
              Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 25),
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.email,
                color: Colors.white,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                email,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.power_settings_new,
                color: Colors.redAccent,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                username,
                style: TextStyle(color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}
