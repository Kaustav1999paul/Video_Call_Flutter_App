import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/models/user.dart';
import 'package:video_call_app/provider/user_provider.dart';
import 'package:video_call_app/screens/pageViews/widgets/user_details_container.dart';
import 'package:video_call_app/utils/universal_variables.dart';

class UserCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final User user = userProvider.getUser;

    return GestureDetector(
      onTap: () => showModalBottomSheet(
          context: context,
          backgroundColor: UniversalVariables.blackColor,
          builder: (context) => UserDetailsContainer(),
          isScrollControlled: false),
      child: CircleAvatar(
        backgroundImage: NetworkImage(user.profilePhoto),
      ),
    );
  }
}
