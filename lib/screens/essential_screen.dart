import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_screen.dart';
import 'chat_screen.dart';
import 'chats_list_screen.dart';
import 'friend_list_screen.dart';

class EssentialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
      ThemeData(primarySwatch: Colors.blue, accentColor: Colors.green),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, user) {
          print('in essential');

          if (!user.hasData) return AuthScreen();
          return ChatsList();
        },
      ),
      routes: {
        FriendListScreen.routName: (ctx) => FriendListScreen(),
        ChatScreen.routName: (ctx) => ChatScreen(),
        ChatsList.routName: (ctx) => ChatsList(),
      },
    );
  }
  }

