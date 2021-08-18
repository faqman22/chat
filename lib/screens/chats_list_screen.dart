import 'package:firebase_flutter/screens/friend_list_screen.dart';
import 'package:firebase_flutter/widgets/existing_chat_list.dart';
import 'package:firebase_flutter/widgets/friends_chat_list.dart';
import 'package:firebase_flutter/widgets/my_dropdown_b.dart';
import 'package:flutter/material.dart';

class ChatsList extends StatefulWidget {
  @override
  _ChatsListState createState() => _ChatsListState();
}

class _ChatsListState extends State<ChatsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
