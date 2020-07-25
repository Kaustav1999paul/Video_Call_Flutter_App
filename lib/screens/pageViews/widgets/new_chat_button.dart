import 'package:flutter/material.dart';
import 'package:video_call_app/utils/universal_variables.dart';

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      decoration: BoxDecoration(
          gradient: UniversalVariables.fabGradient,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Icon(
          Icons.exit_to_app,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
