import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  static Stream<DocumentSnapshot<Map<String, dynamic>>> userDocumentById(
      String id) {
    return FirebaseFirestore.instance.collection('users').doc(id).snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> friendsCollection(
      String uid) {
    return FirebaseFirestore.instance
        .collection('users/$uid/friends')
        .snapshots();
  }
  static Stream<DocumentSnapshot<Map<String, dynamic>>> friendDocumentById(
      String uid, String friendId) {

    return  FirebaseFirestore.instance
        .doc('users/$uid/friends/$friendId')
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> orderedMessages(
      String chatId,{bool descending = false}) {

    return  FirebaseFirestore.instance
        .collection('chats/$chatId/messages')
        .orderBy('date',descending: descending)
        .snapshots();
  }





}
