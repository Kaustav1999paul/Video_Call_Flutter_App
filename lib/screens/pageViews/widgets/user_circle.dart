import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/provider/user_provider.dart';
import 'package:video_call_app/resources/firebase_repository.dart';
import 'package:video_call_app/utils/universal_variables.dart';
import 'package:video_call_app/utils/utilities.dart';

class UserCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
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
              backgroundImage: NetworkImage(
                  Utils.getInitials(userProvider.getUser.profilePhoto)),
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
