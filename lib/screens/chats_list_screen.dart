import 'package:firebase_flutter/helpers/FirebaseHelper.dart';
import 'package:firebase_flutter/models/user_model.dart';

import 'package:firebase_flutter/screens/friend_list_screen.dart';
import 'package:firebase_flutter/widgets/existing_chat_list.dart';

import 'package:firebase_flutter/widgets/my_dropdown_b.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat_screen.dart';

class ChatsList extends StatefulWidget {
  static const routName = '/chatListScreen';
  @override
  _ChatsListState createState() => _ChatsListState();
}

class _ChatsListState extends State<ChatsList> {
  @override
  Widget build(BuildContext context) {

    FirebaseMessaging.instance.getToken();
    FirebaseMessaging.onMessage.listen((mess) {
      print('in onMessage. mess is ${mess.notification!.body}, data is ${mess.data}');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((mess) {
      FirebaseHelper().openChatWithFriend(context, mess);
    });

    var fh = Provider.of<FirebaseHelper>(context, listen: false);
    var isInitial = fh.isInitialized;

    return isInitial
        ? Scaffold(
            appBar: AppBar(
              title: Text('Chats list'),
              actions: [
                MyDropDownButton(),
              ],
            ),
            body: ExistingChatList(),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () =>
                  Navigator.of(context).pushNamed(FriendListScreen.routName),
            ),
          )
        : FutureBuilder(
            future: fh.setInitialValues(),
            builder: (ctx, snp) =>
                snp.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Scaffold(
                        appBar: AppBar(
                          title: Text('Chats list'),
                          actions: [
                            MyDropDownButton(),
                          ],
                        ),
                        body: ExistingChatList(),
                        floatingActionButton: FloatingActionButton(
                          child: Icon(Icons.add),
                          onPressed: () => Navigator.of(context)
                              .pushNamed(FriendListScreen.routName),
                        ),
                      ),
          );
  }
}
