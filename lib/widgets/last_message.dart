import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/helpers/FirebaseHelper.dart';
import 'package:flutter/material.dart';

class LastMessage extends StatelessWidget {
  final chatId;

  LastMessage({required this.chatId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseHelper.orderedMessages(chatId),
      builder: (ctx, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? CircularProgressIndicator()
            : Text(
                (snapshot.data as QuerySnapshot<Map<String, dynamic>>)
                    .docs
                    .last['mess'],
                style: Theme.of(context)
                    .textTheme
                    .caption!.copyWith(fontSize: 14, )
              );
      },
    );
  }
}
