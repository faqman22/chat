import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class DummyData {
  static Future<void> createDummyData() async{
    print('*********** Creating dummy dates... *******');
    var usersNames = ['Alex', 'Ferdinand', 'Kate'];
    var usersId = ['id1', 'id2', 'id3'];
    var collection = FirebaseFirestore.instance.collection('usersTest');
    for (int i = 0; i < 3; i++) {
      var name = usersNames[i];
      var id = usersId[i];

      await collection.doc(id).set({
        'nickName': '${name}_nickName',
        'userName': name,
      });

      var friendsId = List.from(usersId);
      var friendsNames = List.from(usersNames);
      friendsNames.removeAt(i);
      friendsId.removeAt(i);
      for (int k = 0; k < friendsId.length; k++) {
        await collection.doc(id).collection('friends').doc(friendsId[k]).set({
          'friendId': friendsId[k],
          'friendName': friendsNames[k],
          'friendAvatar': '',
        });
      }

  }
  }
}
