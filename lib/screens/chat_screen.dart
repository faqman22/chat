import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/helpers/FirebaseHelper.dart';
import 'package:firebase_flutter/widgets/friend_name.dart';
import 'package:firebase_flutter/widgets/messages.dart';
import 'package:firebase_flutter/widgets/my_dropdown_b.dart';
import 'package:firebase_flutter/widgets/new_message.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const routName = '/chatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final _args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    Future<void> _updateChatId(
        {required String userId,
        required String friendId,
        required String chatId}) async {
      try {
        await FirebaseFirestore.instance
            .doc('users/$userId/friends/$friendId')
            .update({'chatId': chatId});
      } catch (err) {
        print('we had error while updating $err}');
      }
    }

    Future<void> _setFriendChatId(String newChatId) async {
      await _updateChatId(
          userId: _uid, friendId: _args['friendId'], chatId: newChatId);

      await _updateChatId(
          userId: _args['friendId'], friendId: _uid, chatId: newChatId);
    }


    return StreamBuilder(
      stream: FirebaseHelper.friendDocumentById(_uid, _args['friendId']),

      builder: (ctx, snp) {
        if (snp.connectionState == ConnectionState.waiting) return Container();
        var _chatId = (snp.data as DocumentSnapshot)['chatId'];
        return Scaffold(
            appBar: AppBar(
              title: FriendName(
                friendId: _args['friendId'],
                bar: true,
              ),
              actions: [MyDropDownButton()],
            ),
            body: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Messages(
                      chatId: _chatId,
                    ),
                  ),
                  NewMessage(
                    chatId: _chatId,
                    setChatId: _setFriendChatId,
                  ),
                ],
              ),
            ));
      },
    );
  }
}
