import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/helpers/FirebaseHelper.dart';
import 'package:firebase_flutter/models/message_model.dart';
import 'package:firebase_flutter/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class MessagesList extends StatelessWidget {
  final List<Message> messages;

  MessagesList(this.messages);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      padding: EdgeInsets.all(10),
      itemBuilder: (ctx, index) {
        if (messages.isEmpty) return Container();
        var _message = messages[index].text;
        var _isOwn = messages[index].userId ==
            FirebaseHelper().uid;
        return MessageBubble(message: _message, isOwn: _isOwn);
      },
      itemCount: messages.length,
    );
  }
}
