import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyAutocomplete extends StatelessWidget {
  List<Map<String, dynamic>> _allUsers = [];
  TextEditingController _textEditingController = new TextEditingController();

  Iterable<String> _loadOptions(String text) {
    List<String> _options = [];
    _allUsers.forEach((element) {
      String nickName = element['nickName'];
      if (nickName.startsWith(text)) _options.add(nickName);
    });
    return _options;
  }

  Iterable<String> _getOptions(TextEditingValue value) {
    if (value.text.length < 3) return [];
    return _loadOptions(value.text);
  }

  Future<void> _selectedOption(String option) async {
    var user = _allUsers.firstWhere((element) => element['nickName'] == option);
    var friendId = user['uid'];
    var uid = FirebaseAuth.instance.currentUser!.uid;
    _textEditingController.clear();

    await FirebaseFirestore.instance
        .doc('users/$uid/friends/$friendId')
        .set({'chatId': ''}, SetOptions(merge: true));

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('users').get(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState != ConnectionState.waiting)
          (snapshot.data as QuerySnapshot<Map<String, dynamic>>).docs.forEach(
              (doc) => _allUsers
                  .add({'uid': doc.id, 'nickName': doc.data()['nickName']}));

        return Container(
            margin: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            child: Autocomplete<String>(
              optionsBuilder:
                  snapshot.connectionState == ConnectionState.waiting
                      ? (text) => []
                      : _getOptions,
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
