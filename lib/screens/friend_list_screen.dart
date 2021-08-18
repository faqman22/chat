import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/screens/chat_screen.dart';
import 'package:firebase_flutter/widgets/friend_name.dart';
import 'package:firebase_flutter/widgets/friends_list.dart';
import 'package:firebase_flutter/widgets/my_autocomplete.dart';
import 'package:flutter/material.dart';

class FriendListScreen extends StatefulWidget {
  static const routName = '/friends';

  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  @override
  Widget build(BuildContext context) {
    var _uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users/$_uid/friends')
              .snapshots(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            try {
              QuerySnapshot<Map<String, dynamic>> data =
                  snapshot.data as QuerySnapshot<Map<String, dynamic>>;
              List<Map<String, String>> friendsId =
                  data.docs.map((doc) => {'id': doc.id}).toList();

              return Column(children: [
                MyAutocomplete(),
                Expanded(
                  child: FriendsList(friendsId)
                ),
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
    );
  }
}
