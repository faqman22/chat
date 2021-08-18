import 'package:flutter/material.dart';

class FriendAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 30,
        child: Image(
            image: AssetImage(
                'lib/assets/images/avatar-icon-images-4.jpeg')));
  }
}
