import 'package:firebase_flutter/helpers/FirebaseHelper.dart';
import 'package:firebase_flutter/models/chat_model.dart';
import 'package:firebase_flutter/models/user_model.dart';

class ChatsProvider {
  Stream<List<Chat>> chats() {
    return FirebaseHelper().chatsCollection();
  }
}
