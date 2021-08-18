import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter/screens/auth_screen.dart';
import 'package:firebase_flutter/screens/chat_screen.dart';
import 'package:firebase_flutter/screens/chats_list_screen.dart';
import 'package:firebase_flutter/screens/friend_list_screen.dart';
import 'package:flutter/material.dart';

import 'widgets/existing_chat_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, accentColor: Colors.green),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, user) {
          return user.hasData ? ChatsList() : AuthScreen();
        },
      ),
      routes: {
        FriendListScreen.routName: (ctx) => FriendListScreen(),
        ChatScreen.routName: (ctx) => ChatScreen()
      },
    );
  }
}
