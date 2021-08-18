import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/helpers/FirebaseHelper.dart';
import 'package:firebase_flutter/widgets/message_bubble.dart';
import 'package:firebase_flutter/widgets/messages_list.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
  final chatId;

  Messages({required this.chatId});
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    if (widget.chatId == "" || widget.chatId == null) {
      return Container();
    }
    return StreamBuilder(
      stream: FirebaseHelper.orderedMessages(widget.chatId, descending: true),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : MessagesList(snapshot),
    );
  }
}
