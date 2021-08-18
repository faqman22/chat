import 'package:firebase_flutter/screens/chat_screen.dart';
import 'package:firebase_flutter/widgets/friend_name.dart';
import 'package:flutter/material.dart';

class FriendsList extends StatelessWidget {

  final List<Map<String, String>> friendsId;

  FriendsList(this.friendsId);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        var friendId = friendsId[index]['id'];
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
            child: FriendName(
              friendId: friendId,
            ),
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          onTap: () => Navigator.of(context)
              .pushNamed(ChatScreen.routName, arguments: {
            'friendId': friendId,
          }),
        );
      },
      itemCount: friendsId.length,
    );
  }
}
