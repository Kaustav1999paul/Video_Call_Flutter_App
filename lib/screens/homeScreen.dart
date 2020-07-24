import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/provider/user_provider.dart';
import 'package:video_call_app/screens/callScreens/pickup/pickup_layout.dart';
import 'package:video_call_app/screens/pageViews/chat_list_screen.dart';
import 'package:video_call_app/utils/universal_variables.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController;
  int _page = 0;
  UserProvider userProvider;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.refreshUser();
    });
    super.initState();
    pageController = PageController();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: UniversalVariables.blackColor,
        statusBarColor: UniversalVariables.blackColor));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: PickupLayout(
          scaffold: Scaffold(
            backgroundColor: UniversalVariables.blackColor,
            body: PageView(
              children: <Widget>[
                Container(child: ChatListScreen()),
                Center(
                  child: Text(
                    "Call Logs",
                    style: TextStyle(color: UniversalVariables.greyColor),
                  ),
                ),
                Center(
                  child: Text(
                    "My Contacts",
                    style: TextStyle(color: UniversalVariables.greyColor),
                  ),
                ),
              ],
              controller: pageController,
              onPageChanged: onPageChanged,
            ),
            bottomNavigationBar: Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0),
                child: CupertinoTabBar(
                  backgroundColor: UniversalVariables.blackColor,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Icon(Icons.chat,
                            size: 25.0,
                            color: (_page == 0)
                                ? UniversalVariables.lightBlueColor
                                : UniversalVariables.greyColor),
                        title: Text(
                          "Chats",
                          style: TextStyle(
                              fontSize: 10.0,
                              color: (_page == 0)
                                  ? UniversalVariables.lightBlueColor
                                  : UniversalVariables.greyColor),
                        )),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.call,
                            size: 25.0,
                            color: (_page == 1)
                                ? UniversalVariables.lightBlueColor
                                : UniversalVariables.greyColor),
                        title: Text(
                          "Chats",
                          style: TextStyle(
                              fontSize: 10.0,
                              color: (_page == 1)
                                  ? UniversalVariables.lightBlueColor
                                  : UniversalVariables.greyColor),
                        )),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.contact_phone,
                            size: 25.0,
                            color: (_page == 2)
                                ? UniversalVariables.lightBlueColor
                                : UniversalVariables.greyColor),
                        title: Text(
                          "Chats",
                          style: TextStyle(
                              fontSize: 10.0,
                              color: (_page == 2)
                                  ? UniversalVariables.lightBlueColor
                                  : UniversalVariables.greyColor),
                        ))
                  ],
                  onTap: navigationTapped,
                  currentIndex: _page,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
