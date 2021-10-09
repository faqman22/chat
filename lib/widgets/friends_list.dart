import 'package:firebase_flutter/models/chat_model.dart';
import 'package:firebase_flutter/models/user_model.dart';
import 'package:firebase_flutter/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class FriendsList extends StatelessWidget {
  final List<Chat> chats;

  final List<FireBaseUser> friends;

  FriendsList({required this.friends, required this.chats});

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemBuilder: (ctx, index) {
        var friend = friends[index];
        var chatIndex = chats.indexWhere((chat) => chat.user.id == friend.id);

        return ListTile(
          minVerticalPadding: 15,
          leading: Container(
            child: CircleAvatar(
                radius: 30,
                child: Image(
                    image: AssetImage(
                        'lib/assets/images/avatar-icon-images-4.jpeg'))),
          ),
          subtitle: Container(
            child: Text(
              friend.name,
              style:
                  Theme.of(context).textTheme.headline6!.copyWith(fontSize: 16),
            ),
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          onTap: () =>
              Navigator.of(context).pushNamed(ChatScreen.routName, arguments: {
            'user': friend,
            'chatId': chatIndex == -1 ? '' : chats[chatIndex].chatId
          }),
        );
      },
      itemCount: friends.length,
    );
  }
}
