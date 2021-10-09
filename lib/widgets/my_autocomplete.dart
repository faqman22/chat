import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter/helpers/FirebaseHelper.dart';
import 'package:firebase_flutter/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MyAutocomplete extends StatelessWidget {
  List<FireBaseUser> _allUsers = [];
  TextEditingController _textEditingController = new TextEditingController();

  Iterable<String> _loadOptions(BuildContext ctx, String text) {
    var currentUser = Provider.of<FirebaseHelper>(ctx, listen: false).currentUser;

    List<String> _options = [];
    _allUsers.forEach((user) {
      String nickName = user.nickName;
      if (nickName.startsWith(text) && nickName != currentUser!.nickName)
        _options.add(nickName);
    });
    return _options;
  }

  Iterable<String> _getOptions(BuildContext ctx, TextEditingValue value) {
    if (value.text.length < 3) return [];
    return _loadOptions(ctx, value.text);
  }

  Future<void> _selectedOption(String option) async {
    var user = _allUsers.firstWhere((user) => user.nickName == option);

    print('selected user is $user');
    var id = user.id;
    var name = user.name;
    var nickName = user.nickName;
    var uid = FirebaseHelper().uid;
    _textEditingController.clear();

    await FirebaseFirestore.instance.doc('users/$uid/friends/$id').set(
        {'avatar': '', 'id': id, 'name': name, 'nickName': nickName},
        SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('users').get(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState != ConnectionState.waiting)
          (snapshot.data as QuerySnapshot<Map<String, dynamic>>)
              .docs
              .forEach((doc) => _allUsers.add(FireBaseUser(
                    id: doc.id,
                    nickName: doc.data()['nickName'],
                    name:  doc.data()['name']
                  )));

        return Container(
            margin: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            child: Autocomplete<String>(
              optionsBuilder:
                  snapshot.connectionState == ConnectionState.waiting
                      ? (text) => []
                      : (text) => _getOptions(ctx, text),
              fieldViewBuilder: (context, textEditingController, focusNode,
                  onFieldSubmitted) {
                _textEditingController = textEditingController;
                return TextField(
                  decoration:
                      InputDecoration(labelText: 'Please, enter user nickname'),
                  controller: _textEditingController,
                  focusNode: focusNode,
                );
              },
              onSelected: _selectedOption,
            ));
      },
    );
  }
}
