import 'package:firebase_flutter/screens/chat_screen.dart';
import 'package:firebase_flutter/widgets/friend_avatar.dart';
import 'package:firebase_flutter/widgets/friend_name.dart';
import 'package:firebase_flutter/widgets/last_message.dart';
import 'package:flutter/material.dart';

class FriendListTile extends StatelessWidget {

  final friendId;
  final chatId;

  FriendListTile({required this.friendId, required this.chatId});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 15,
      leading: Container(
        margin: EdgeInsets.only(left: 8),
        child: FriendAvatar(),
      ),
      subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: FriendName(
                friendId: friendId,
              ),
              padding: EdgeInsets.only(top: 5),
            ),
            Container(
              child: LastMessage(
                chatId: chatId,
              ),
              padding: EdgeInsets.symmetric(vertical: 7),
            ),
          ]),
      onTap: () => Navigator.of(context)
          .pushNamed(ChatScreen.routName, arguments: {
        'friendId': friendId,
      }),
    );
  }
}
