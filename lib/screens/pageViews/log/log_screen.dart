import 'package:flutter/material.dart';
import 'package:video_call_app/screens/callScreens/pickup/pickup_layout.dart';
import 'package:video_call_app/screens/pageViews/widgets/log_list_container.dart';
import 'package:video_call_app/utils/universal_variables.dart';

class LogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: UniversalVariables.blackColor,
        body: Padding(
          padding: EdgeInsets.all(10),
          child: LogListContainer(),
        ),
      ),
    );
  }
}
