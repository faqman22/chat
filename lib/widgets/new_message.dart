import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
  final chatId;
  final Function(String chatId) setChatId;

  NewMessage({required this.chatId, required this.setChatId});
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  var _controller = new TextEditingController();
  var _uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> _sendMessage() async {
    FocusScope.of(context).unfocus();
    if (widget.chatId == "" || widget.chatId == null) {
      try {
        var chatIdPath =
            await FirebaseFirestore.instance.collection('chats').add({});
        chatIdPath.collection('messages').add({
          'mess': _enteredMessage,
          'date': Timestamp.now(),
          'userId': _uid,
        });
        widget.setChatId(chatIdPath.id);
        _controller.clear();
      } catch (err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('We can\'t send message, something went wrong')));
      }
    } else {
      FirebaseFirestore.instance
          .collection('chats/${widget.chatId}/messages')
          .add({
        'mess': _enteredMessage,
        'date': Timestamp.now(),
        'userId': _uid
      });
      _controller.clear();
    }
  }

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
              onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage)
        ],
      ),
    );
  }
}
