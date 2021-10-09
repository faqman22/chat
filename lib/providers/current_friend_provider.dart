import 'package:firebase_flutter/models/user_model.dart';

class CurrentFriend {

  late FireBaseUser? _friend;
  FireBaseUser get friend => _friend!;

  set friend(FireBaseUser friend) =>
      _friend = friend;
}