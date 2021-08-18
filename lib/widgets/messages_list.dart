import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class MessagesList extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot> snapshot;

  MessagesList(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      padding: EdgeInsets.all(10),
      itemBuilder: (ctx, index) {
        if (snapshot.data == null) return Container();
        var _message = snapshot.data!.docs[index]['mess'];
        var _isOwn = snapshot.data!.docs[index]['userId'] ==
            FirebaseAuth.instance.currentUser!.uid;
        return MessageBubble(message: _message, isOwn: _isOwn);
      },
      itemCount: snapshot.data?.size ?? 0,
    );
  }
}
