import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/helpers/FirebaseHelper.dart';

import 'package:firebase_flutter/widgets/friend_list_tile.dart';

import 'package:flutter/material.dart';

class ExistingChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _uid = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
        stream: FirebaseHelper.friendsCollection(_uid),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          QuerySnapshot<Map<String, dynamic>> data =
              snapshot.data as QuerySnapshot<Map<String, dynamic>>;

          List<Map<String, String>> _friendsDocuments = [];
          data.docs.forEach((doc) {
            String chatId = doc.data()['chatId'];
            if (chatId != '' || chatId.isNotEmpty)
              _friendsDocuments.add({
                'chatId': chatId,
                'friendId': doc.id
              });
          });

          if (_friendsDocuments.length != 0) {
            return ListView.builder(
              itemBuilder: (ctx, index) {
                var _chatId = _friendsDocuments[index]['chatId'];
                if (_chatId == "" || _chatId == null) return Container();
                var _friendId = _friendsDocuments[index]['friendId'];

                return FriendListTile(
                  friendId: _friendId,
                  chatId: _chatId,
                );
              },
              itemCount: _friendsDocuments.length,
            );
          }

          return Center(
            child: Text('Don\'t have any chat. Time to start!'),
          );
        });
  }
}
