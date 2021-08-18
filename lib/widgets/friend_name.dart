import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/helpers/FirebaseHelper.dart';
import 'package:flutter/material.dart';

class FriendName extends StatelessWidget {
  final friendId;
  var bar;

  FriendName({required this.friendId, this.bar = false});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseHelper.userDocumentById(friendId),
        builder: (ctx, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? CircularProgressIndicator()
              : Text(
                  (snapshot.data as DocumentSnapshot)['userName'],
                  style: bar ? null : Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 16),
                );
        });
  }
}
