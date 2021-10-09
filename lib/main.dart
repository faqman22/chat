import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter/helpers/FirebaseHelper.dart';

import 'package:firebase_flutter/providers/chats_provider.dart';
import 'package:firebase_flutter/providers/friends_provider.dart';
import 'package:firebase_flutter/screens/essential_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/chat_model.dart';
import 'models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<FireBaseUser>>(
            create: (ctx) => FriendsProvider().friends(), initialData: []),
        StreamProvider<List<Chat>?>(
          create: (ctx) => ChatsProvider().chats(),
          initialData: null,
          catchError: (ctx, err) {
            print('err in provider List<Chat> $err');
            return null;
          },
        ),

        ChangeNotifierProvider<FirebaseHelper>(
            create: (ctx) => FirebaseHelper()),
//        Provider<CurrentFriend>(create: (ctx) => CurrentFriend())
      ],
      child: EssentialScreen(),
    );
  }
}
