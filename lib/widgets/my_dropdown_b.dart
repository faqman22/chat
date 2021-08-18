import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDropDownButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      icon: Icon(
        Icons.more_vert,
        color: Theme.of(context).primaryIconTheme.color,
      ),
      items: [
        DropdownMenuItem(
          child: Container(
            child: Row(
              children: [
                Icon(
                  Icons.exit_to_app,
                  color: Colors.amberAccent,
                ),
                SizedBox(
                  width: 3,
                ),
                Text('Logout')
              ],
            ),
          ),
          value: 'logout',
        )
      ],
      onChanged: (value) {
        if (value == 'logout') FirebaseAuth.instance.signOut();
      },
    );
  }
}
