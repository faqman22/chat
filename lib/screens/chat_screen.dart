import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/helpers/FirebaseHelper.dart';
import 'package:firebase_flutter/models/chat_model.dart';
import 'package:firebase_flutter/models/user_model.dart';
import 'package:firebase_flutter/providers/current_friend_provider.dart';
import 'package:firebase_flutter/screens/chats_list_screen.dart';
import 'package:firebase_flutter/widgets/messages.dart';
import 'package:firebase_flutter/widgets/my_dropdown_b.dart';
import 'package:firebase_flutter/widgets/new_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static const routName = '/chatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final FireBaseUser currentFriend = (ModalRoute.of(context)!
        .settings
        .arguments as Map<String, dynamic>)['user']!;
    var currentUser = Provider.of<FirebaseHelper>(context).currentUser!;


        return Consumer<List<Chat>?>(
          builder: (ctx, chats, _) {
            if (chats == null)
              return Center(
                child: CircularProgressIndicator(),
              );

            var chatIndex = chats
                .indexWhere((chat) => chat.user.id == currentFriend.id);
            var chatId = chatIndex == -1 ? '' : chats[chatIndex].chatId;
            return Scaffold(
                appBar: AppBar(
                  title: Text(currentFriend.name),
                  leading: Navigator.of(context).canPop()? null : IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pushReplacementNamed(ChatsList.routName),),
                  actions: [MyDropDownButton()],

                ),
                body: Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: Messages(
                          chatId: chatId,
                        ),
                      ),
                      NewMessage(
                          chatId: chatId,
                          currentUser: currentUser,
                          currentFriend: currentFriend),
                    ],
                  ),
                ));
          },
        );


  }
}
