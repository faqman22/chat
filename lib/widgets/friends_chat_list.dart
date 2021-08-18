import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/widgets/chat_preview.dart';
import 'package:flutter/material.dart';

class FriendsChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _uid = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users/$_uid/friends')
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          QuerySnapshot<Map<String, dynamic>> data = snapshot.data as QuerySnapshot<Map<String, dynamic>>;
          List<String> _friends =
              List.from(data.docs[0].data()['friends_list']);
          

          return ListView.builder(
            itemBuilder: (ctx, index) {
              return Row(children: [
                Container(
                  margin: EdgeInsets.only(left: 8),
                  child: CircleAvatar(
                      radius: 30,
                      child: Image(
                          image: AssetImage(
                              'lib/assets/images/avatar-icon-images-4.jpeg'))),
                ),
                Card(
                    margin: EdgeInsets.all(13),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc('${_friends[index]}')
                                  .snapshots(),
                              builder: (ctx, snapshot) {
                                return snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? CircularProgressIndicator()
                                    : Text(
                                  (snapshot.data as DocumentSnapshot)['userName'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(fontSize: 20),
                                      );
                              },
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10),
                          ),
                          ChatPreview(
                            uid: _uid,
                            friendId: _friends[index],
                          )
                        ])),
              ]);
            },
            itemCount: _friends.length,
          );
        });
  }
}
