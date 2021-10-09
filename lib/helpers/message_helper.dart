import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'FirebaseHelper.dart';

class MessageHelper {
  static Future<void> setFriendChatId(
      FireBaseUser userOne, FireBaseUser userTwo, String newChatId) async {
    await FirebaseHelper().addNewChat(
        user: userOne, friend: userTwo, chatId: newChatId);
    await FirebaseHelper().addNewChat(
        user: userTwo, friend: userOne, chatId: newChatId);
  }

  static Future<void> sendMessage(
      {required BuildContext context,
      required String chatId,
      required FireBaseUser currentUser,
      required FireBaseUser currentFriend,
      required String message,
      required TextEditingController controller}) async {
    FocusScope.of(context).unfocus();
    if (chatId.isEmpty) {
      try {
        var chatIdPath =
            await FirebaseFirestore.instance.collection('chats').add({});
        chatIdPath.collection('messages').add({
          'mess': message,
          'date': Timestamp.now(),
          'from': {
            'id': currentUser.id,
            'name': currentUser.name,
            'nick': currentUser.nickName,
            'avatar': currentUser.avatar
          },
          'to': {
            'id': currentFriend.id,
            'name': currentFriend.name,
            'nick': currentFriend.nickName,
            'avatar': currentFriend.avatar
          }
        });
        await setFriendChatId(currentUser, currentFriend, chatIdPath.id);
        controller.clear();
      } catch (err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('We can\'t send message, something went wrong')));
      }
    } else {
      FirebaseFirestore.instance.collection('chats/$chatId/messages').add({
        'mess': message,
        'date': Timestamp.now(),
        'from': {
          'id': currentUser.id,
          'name': currentUser.name,
          'nick': currentUser.nickName,
          'avatar': currentUser.avatar
        },
        'to': {
          'id': currentFriend.id,
          'name': currentFriend.name,
          'nick': currentFriend.nickName,
          'avatar': currentFriend.avatar
        }
      });
      controller.clear();
    }
  }
}
