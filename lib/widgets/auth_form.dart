import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String mail, String pass, String name, bool isLogin)
      _sendForm;
  final bool _isLoading;

  AuthForm(this._sendForm, this._isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPass = '';

  void _submit() {
    final isValidate = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValidate) {
      _formKey.currentState!.save();
      widget._sendForm(_userEmail, _userPass, _userName, _isLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (value) => _userEmail = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return 'Password must be at least 7 characters long';
                    }
                    return null;
                  },
                  onSaved: (value) => _userPass = value!,
                ),
                if (!_isLogin)
                  TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'User Name'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 3) {
                        return 'Please enter at least 3 characters';
                      }
                      return null;
                    },
                    onSaved: (value) => _userName = value!,
                  ),
                SizedBox(
                  height: 20,
                ),
                widget._isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        ),
                      )
                    : CupertinoButton.filled(
                        onPressed: _submit,
                        child: Text(_isLogin ? 'Login' : 'Sign up')),
                CupertinoButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(_isLogin
                      ? 'Create new account'
                      : 'I already have an account'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
