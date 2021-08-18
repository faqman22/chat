import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPreview extends StatelessWidget {
  final uid;
  final friendId;

  ChatPreview({@required this.uid, @required this.friendId});


  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
            minWidth: 140, maxWidth: 300),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users/$uid/chatids')
                .snapshots(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return Container();
              }
              QuerySnapshot<Map<String, dynamic>> snp =
                  snapshot.data as QuerySnapshot<Map<String, dynamic>>;
              print(
                  snp.docs[0].data()[friendId]);

              String _messagesHistory =
              snp.docs[0].data()[friendId];
              return Text(
                _messagesHistory.isEmpty
                    ? 'Start chat...'
                    : _messagesHistory,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText2,
                maxLines: 2,
              );
            }));
  }
}
