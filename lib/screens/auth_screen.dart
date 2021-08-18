import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/widgets/auth_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;

  void _sendForm(
      String email, String password, String name, bool isLogin) async {
    setState(() {
      _isLoading = true;
    });

    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      if (isLogin) {
        final credentials = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        final authResult =  await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await FirebaseFirestore.instance.collection('users').doc(authResult.user!.uid).set({'userName' : name});
      }
    } on FirebaseAuthException catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed: ${err.message}'),
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print('Something went wrong while send form to firebase. ');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auth'),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_sendForm, _isLoading),
    );
  }
}
