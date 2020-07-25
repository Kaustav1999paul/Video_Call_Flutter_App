import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/constants/strings.dart';
import 'package:video_call_app/models/user.dart';
import 'package:video_call_app/provider/user_provider.dart';
import 'package:video_call_app/resources/myContacts.dart';
import 'package:video_call_app/screens/callScreens/pickup/pickup_layout.dart';
import 'package:video_call_app/screens/chatScreens/chat_screen.dart';
import 'package:video_call_app/screens/chatScreens/widgets/cached_image.dart';
import 'package:video_call_app/screens/pageViews/widgets/quiet_box.dart';
import 'package:video_call_app/screens/pageViews/widgets/user_circle.dart';
import 'package:video_call_app/screens/search_screen.dart';
import 'package:video_call_app/utils/universal_variables.dart';
import 'package:video_call_app/widgets/appbar.dart';

class MyContactsListSccreen extends StatelessWidget {
  CustomAppBar customAppBar(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final User user = userProvider.getUser;

    return CustomAppBar(
      title: UserCircle(),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: UniversalVariables.blackColor,
        appBar: customAppBar(context),
        body: MyConct(),
      ),
    );
  }
}

class MyConct extends StatefulWidget {
  @override
  _MyConctState createState() => _MyConctState();
}

class _MyConctState extends State<MyConct> {
  Future getContactsList() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("users").getDocuments();
    return qn.documents;
  }

  navigateToDetails(User post) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(
            receiver: post,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
      future: getContactsList(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () => navigateToDetails(snapshot.data[index]),
                title: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      CachedImage(
                        snapshot.data[index].data["profile_photo"],
                        isRound: true,
                        radius: 60,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            snapshot.data[index].data["name"],
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            snapshot.data[index].data["username"],
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w100),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    ));
  }
}

// Text(snapshot.data[index].data["name"])
