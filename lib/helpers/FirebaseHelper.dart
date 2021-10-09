import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/models/chat_model.dart';
import 'package:firebase_flutter/models/message_model.dart';
import 'package:firebase_flutter/models/user_model.dart';
import 'package:firebase_flutter/screens/chat_screen.dart';
import 'package:firebase_flutter/screens/chats_list_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseHelper with ChangeNotifier {
  final String MAINCOLLECTIONPATH = 'users';
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  FireBaseUser? _currentUser;
  bool isInitialized = false;

  void logout() {
    isInitialized = false;
    FirebaseAuth.instance.signOut();
  }

  void openChatWithFriend(BuildContext context, RemoteMessage mess){
      FireBaseUser user = FireBaseUser(name: mess.data['name'], id: mess.data['id'], nickName: mess.data['nick']);
      var chatId = mess.data['chatId'];
      print('in onMessageOpenedApp. mess is ${mess.notification!.body} data is ${mess.data}, chatId is $chatId');
      Navigator.of(context).pushReplacementNamed(ChatScreen.routName, arguments: {
        'user': user,
        'chatId': mess.data['chatId']
      },);
  }

  Future<void> setInitialValues() async {
    FirebaseMessaging.instance.getToken();

    FirebaseMessaging.instance.subscribeToTopic(uid).then((value) {
      print('finish subscribing');
    });
    var snp =
        await FirebaseFirestore.instance.doc('$MAINCOLLECTIONPATH/$uid').get();
    _currentUser = FireBaseUser(
        name: snp.data()!['name'],
        id: snp.id,
        nickName: snp.data()!['nickName']);
    isInitialized = true;
  }

  FireBaseUser? get currentUser => _currentUser;

  Future<bool> checkEmptyCollection() async {
    var snp = await FirebaseFirestore.instance
        .collection('$MAINCOLLECTIONPATH')
        .get();
    return snp.docs.length == 0;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> friendsCollectionSnapShot() {
    return FirebaseFirestore.instance
        .collection('$MAINCOLLECTIONPATH/$uid/friends')
        .snapshots();
  }

  Stream<List<Chat>> chatsCollection() {
    return FirebaseFirestore.instance
        .collection('$MAINCOLLECTIONPATH/$uid/userChats')
        .snapshots()
        .map((snp) => snp.docs.isEmpty
            ? []
            : snp.docs
                .map((doc) => Chat(
                    chatId: doc['chatId'],
                    user: FireBaseUser(
                        name: doc['name'],
                        nickName: doc['nickName'],
                        id: doc['id'])))
                .toList());
  }

  Stream<List<Message>> orderedMessages(String chatId,
      {bool descending = false}) {
    return FirebaseFirestore.instance
        .collection('chats/$chatId/messages')
        .orderBy('date', descending: descending)
        .snapshots()
        .map((snp) {
      if (snp.docs.length == 0) return [];

      return snp.docs.map((doc) {
        return Message(text: doc['mess'], userId: doc['from']['id']);
      }).toList();
    });
  }

  Future<void> addNewChat(
      {required FireBaseUser user,
      required FireBaseUser friend,
      required String chatId}) async {
    try {
      print('in add chat. id is ${user.id}');
      await FirebaseFirestore.instance
          .collection('$MAINCOLLECTIONPATH/${user.id}/userChats/')
          .add({
        'chatId': chatId,
        'name': friend.name,
        'nickName': friend.nickName,
        'id': friend.id
      });
    } catch (err) {
      print('we had error while add new chat $err}');
    }
  }

  Future<bool> checkUniqueNickName(String nickName) async {
    var snp = await FirebaseFirestore.instance.doc('nickNames/arrayDoc').get();

    List<dynamic> nickNames = snp.data()!['list'];

    var index = nickNames.indexWhere((nkName) => nkName == nickName);
    return index == -1;
  }
}
