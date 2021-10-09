import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/helpers/FirebaseHelper.dart';
import 'package:firebase_flutter/helpers/message_helper.dart';
import 'package:firebase_flutter/models/user_model.dart';
import 'package:firebase_flutter/providers/current_friend_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
  final String chatId;
  final FireBaseUser currentUser;
  final FireBaseUser currentFriend;

  NewMessage(
      {required this.chatId,
      required this.currentUser,
      required this.currentFriend});
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  var _controller = new TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Enter new message'),
            onChanged: (value) {
              setState(() {
                _enteredMessage = value;
              });
            },
          )),
          IconButton(
              icon: Icon(Icons.send),
              onPressed: _enteredMessage.trim().isEmpty
                  ? null
                  : () => MessageHelper.sendMessage(
                      context: context,
                      chatId: widget.chatId,
                      currentUser: widget.currentUser,
                      currentFriend: widget.currentFriend,
                      message: _enteredMessage,
                      controller: _controller))
        ],
      ),
    );
  }
}
