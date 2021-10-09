import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/helpers/FirebaseHelper.dart';
import 'package:firebase_flutter/models/message_model.dart';
import 'package:flutter/material.dart';

class LastMessage extends StatelessWidget {
  final chatId;

  LastMessage({required this.chatId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseHelper().orderedMessages(chatId),
      builder: (ctx, AsyncSnapshot<List<Message>> snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? CircularProgressIndicator()
            : Text(snapshot.data!.last.text,
                style: Theme.of(context)
                    .textTheme
                    .caption!.copyWith(fontSize: 14, )
              );
      },
    );
  }
}
