import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/helpers/FirebaseHelper.dart';
import 'package:firebase_flutter/main.dart';
import 'package:firebase_flutter/models/chat_model.dart';
import 'package:firebase_flutter/models/user_model.dart';

import 'package:firebase_flutter/widgets/friend_list_tile.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExistingChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

      return Consumer<List<Chat>?>(builder: (ctx, chats, child) {
        return chats == null || chats.isEmpty
            ? Center(
          child: Text('Don\'t have any chat. Time to start!'),
        )
            : ListView.builder(
          itemBuilder: (ctx, index) {
            return FriendListTile(
              name: chats[index].user.name,
              nicName: chats[index].user.nickName,
              userId: chats[index].user.id,
              chatId: chats[index].chatId,
            );
          },
          itemCount: chats.length,
        );
      });
  }
}
