import 'package:firebase_flutter/helpers/FirebaseHelper.dart';

import 'package:firebase_flutter/models/user_model.dart';

class FriendsProvider {
  Stream<List<FireBaseUser>> friends() {
    var friendsList = FirebaseHelper().friendsCollectionSnapShot().map((coll) {
      var docs = coll.docs;
      if (docs.isEmpty) return <FireBaseUser>[];
      return docs.map((doc) {

        return FireBaseUser(
          name: doc.data()['name'],
          nickName: doc.data()['nickName'],
          id: doc.id,
        );
      }).toList();
    });

    return friendsList;
  }
}
