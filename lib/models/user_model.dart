import 'package:flutter/foundation.dart';

class FireBaseUser {
  final String name;
  final String avatar;
  final String id;
  final String nickName;

  FireBaseUser({required this.name, required this.id,  required this.nickName, this.avatar = 'lib/assets/images/avatar-icon-images-4.jpeg'});
}