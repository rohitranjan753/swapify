import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vbuddyproject/Components/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);

  final bool isLoading;
  final void Function(
      String email,
      String password,
      String username,
      // File image,
      bool isLogin,
      BuildContext context,
      ) submitFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPass = '';
  // var _userImageFile;

  // void _pickedImage(File image) {
  //   _userImageFile = image;
  // }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();

    //for keyboard lec 325
    FocusScope.of(context).unfocus();

    // if (_userImageFile == null && !_isLogin) {
    //   Scaffold.of(context).showSnackBar(SnackBar(
    //     content: Text("Please pick an image."),
    //     backgroundColor: Theme.of(context).errorColor,
    //   ));
    //   return;
    // }

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
          _userEmail.trim(),
          _userPass.trim(),
          _userName.trim(),
          // _userImageFile,
          _isLogin,
          context);

      //use valeu to save data
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // if (!_isLogin) UserImagePicker(_pickedImage),
                  TextFormField(
                    key: ValueKey('email'),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,

                    validator: (value) {
                      if (value!.isEmpty || value.contains('*')) {
                        return 'Pleas enter valid email address';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: "Email Address",
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)
                      ),),
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                  ),
                  SizedBox(height: 10,),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      enableSuggestions: false,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'please enter more than 4';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(labelText: "Username",
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                        ),),
                      onSaved: (value) {
                        _userName = value!;
                      },
                    ),
                  SizedBox(height: 10,),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Pleas enter greater than 7';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(labelText: "Password",
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)
                      ),),
                    obscureText: true,
                    onSaved: (value) {
                      _userPass = value!;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      color: Colors.greenAccent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      ),
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? "LOGIN" : 'SIGNUP'),
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? "Create new account"
                          : 'I already have an account'),
                    ),
                ],
              ),
            ),
          ),
        ),

      ),

    );
  }
}
