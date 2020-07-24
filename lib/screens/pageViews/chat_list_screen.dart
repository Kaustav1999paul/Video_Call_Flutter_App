import 'package:flutter/material.dart';
import 'package:video_call_app/resources/firebase_repository.dart';
import 'package:video_call_app/screens/search_screen.dart';
import 'package:video_call_app/utils/universal_variables.dart';
import 'package:video_call_app/utils/utilities.dart';
import 'package:video_call_app/widgets/appbar.dart';
import 'package:video_call_app/widgets/custom_tile.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

final FirebaseRepository _repository = FirebaseRepository();
String avatar;

class _ChatListScreenState extends State<ChatListScreen> {
  String currentUserId;
  String initials;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _repository.getCurrentUser().then((user) {
      setState(() {
        currentUserId = user.uid;
        avatar = user.photoUrl;
        initials = Utils.getInitials(user.displayName);
      });
    });
  }

  CustomAppBar customAppBar(BuildContext context) {
    return CustomAppBar(
      title: UserCircle(initials),
      centerTitle: false,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SearchScreen()));
          },
        ),
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      appBar: customAppBar(context),
      floatingActionButton: NewChatButton(),
      body: ChatListContainer(currentUserId),
    );
  }
}

class ChatListContainer extends StatefulWidget {
  final String currentUserId;

  ChatListContainer(this.currentUserId);

  @override
  _ChatListContainerState createState() => _ChatListContainerState();
}

class _ChatListContainerState extends State<ChatListContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: 1,
          itemBuilder: (context, index) {
            return CustomTile(
              mini: false,
              title: Text(
                "Kaustav Paul",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 19.0,
                    fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                "Hello",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w300),
              ),
              leading: Container(
                constraints: BoxConstraints(maxHeight: 50, maxWidth: 50),
                child: Stack(
                  children: <Widget>[
                    CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                          "https://lh3.googleusercontent.com/a-/AOh14GipErUJkNHK97CFMrDdAhW-iXURpY1mDjRLFeQCXw=s96-c"),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 13,
                        width: 13,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: UniversalVariables.onlineDotColor,
                            border: Border.all(
                                color: UniversalVariables.blackColor,
                                width: 2)),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class UserCircle extends StatelessWidget {
  final String text;

  UserCircle(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: UniversalVariables.separatorColor,
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              backgroundImage: NetworkImage(avatar),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: UniversalVariables.blackColor, width: 2),
                  color: UniversalVariables.onlineDotColor),
            ),
          )
        ],
      ),
    );
  }
}

class NewChatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: UniversalVariables.fabGradient,
          borderRadius: BorderRadius.circular(50)),
      child: Icon(
        Icons.edit,
        color: Colors.white,
        size: 25,
      ),
      padding: EdgeInsets.all(15),
    );
  }
}
