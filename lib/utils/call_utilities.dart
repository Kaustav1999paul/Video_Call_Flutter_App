import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_call_app/constants/strings.dart';
import 'package:video_call_app/models/call.dart';
import 'package:video_call_app/models/log.dart';
import 'package:video_call_app/models/user.dart';
import 'package:video_call_app/resources/call_methods.dart';
import 'package:video_call_app/resources/local_db/repository/log_repository.dart';
import 'package:video_call_app/screens/callScreens/call_screen.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial({User from, User to, context}) async {
    Call call = Call(
      callerId: from.uid,
      callerName: from.name,
      callerPic: from.profilePhoto,
      receiverId: to.uid,
      receiverName: to.name,
      receiverPic: to.profilePhoto,
      channelId: Random().nextInt(1000).toString(),
    );

    Log log = Log(
      callerName: from.name,
      callerPic: from.profilePhoto,
      callStatus: CALL_STATUS_DIALLED,
      receiverName: to.name,
      receiverPic: to.profilePhoto,
      timestamp: DateTime.now().toString(),
    );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      LogRepository.addLogs(log);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallScreen(call: call),
          ));
    }
  }
}
