import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/models/contact.dart';
import 'package:video_call_app/provider/user_provider.dart';
import 'package:video_call_app/resources/chat_methods.dart';
import 'package:video_call_app/resources/firebase_repository.dart';
import 'package:video_call_app/screens/callScreens/pickup/pickup_layout.dart';
import 'package:video_call_app/screens/pageViews/widgets/contact_view.dart';
import 'package:video_call_app/screens/pageViews/widgets/new_chat_button.dart';
import 'package:video_call_app/screens/pageViews/widgets/quiet_box.dart';
import 'package:video_call_app/screens/pageViews/widgets/user_circle.dart';
import 'package:video_call_app/screens/search_screen.dart';
import 'package:video_call_app/utils/universal_variables.dart';
import 'package:video_call_app/utils/utilities.dart';
import 'package:video_call_app/widgets/appbar.dart';
import 'package:video_call_app/widgets/custom_tile.dart';

class ChatListScreen extends StatelessWidget {
  CustomAppBar customAppBar(BuildContext context) {
    return CustomAppBar(
      leading: IconButton(
        icon: Icon(
          Icons.notifications,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      title: UserCircle(),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/search_screen");
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
    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: UniversalVariables.blackColor,
        appBar: customAppBar(context),
        floatingActionButton: NewChatButton(),
        body: ChatListContainer(),
      ),
    );
  }
}

class ChatListContainer extends StatelessWidget {
  final ChatMethods _chatMethods = ChatMethods();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: _chatMethods.fetchContacts(
            userId: userProvider.getUser.uid,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var docList = snapshot.data.documents;

              if (docList.isEmpty) {
                return QuietBox();
              }
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: docList.length,
                itemBuilder: (context, index) {
                  Contact contact = Contact.fromMap(docList[index].data);

                  return ContactView(contact);
                },
              );
            }

            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
