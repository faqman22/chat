import 'package:firebase_flutter/helpers/FirebaseHelper.dart';
import 'package:firebase_flutter/models/chat_model.dart';
import 'package:firebase_flutter/models/user_model.dart';
import 'package:firebase_flutter/widgets/friends_list.dart';
import 'package:firebase_flutter/widgets/my_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendListScreen extends StatefulWidget {
  static const routName = '/friends';

  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends'),
      ),
      body:  StreamBuilder<List<Chat>>(
        stream: FirebaseHelper().chatsCollection(),
        builder: (ctx, snp) => snp.connectionState == ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<List<FireBaseUser>>(builder: (ctx, friends, child) {
                try {
                  return Column(children: [
                    MyAutocomplete(),
                    Expanded(
                        child: FriendsList(
                      friends: friends,
                      chats: snp.data!,
                    )),
                  ]);
                } catch (err) {
                  print('error while try rendering friend list screen: $err');
                  return Container(
                    child: Center(
                      child: Text('Something went wrong'),
                    ),
                  );
                }
              }),
      ),
    );
  }
}
