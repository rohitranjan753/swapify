import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:vbuddyproject/Constants/color_constant.dart';
import 'package:vbuddyproject/Constants/image_string.dart';
import 'package:vbuddyproject/Constants/sizes.dart';
import 'package:vbuddyproject/nav_bar.dart';

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
  bool isLoadingIndicator = false;
  final String defaultImageLogo =
      'https://firebasestorage.googleapis.com/v0/b/vbuddyproject-99a8a.appspot.com/o/images%2Fuser_logo.png?alt=media&token=debafca9-68fc-499d-b2a1-5e12f2e2f665';
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool passwordVisible = true;
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
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(

            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Image
                _isLogin
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            'assets/welcome_hi.json',
                            height: size.height * 0.2,
                            repeat: true,
                            reverse: true,
                          ),

                          // Image(
                          //   image: AssetImage("assets/hello_pic-removebg-preview.png"),
                          //   height: size.height * 0.2,
                          // ),
                          Text(
                            "Welcome back",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Text(
                            "Let's continue the journey",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            loginImageLottie,
                            height: size.height * 0.2,
                            repeat: true,
                            reverse: true,
                          ),
                          // Image(
                          //   image: AssetImage("assets/signup_boy.png"),
                          //   height: size.height * 0.2,
                          // ),

                          Text(
                            "Get On Board",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Text(
                            "Your marketplace for smart exchanges",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // if (!_isLogin) UserImagePicker(_pickedImage),
                        if (!_isLogin)
                          //username
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
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              labelText: "Username",
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (value) {
                              _userName = value!;
                            },
                          ),
                        SizedBox(
                          height: tDefaultSize - 10,
                        ),

                        //Email
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
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            hintText: "abc@gmail.com",
                            labelText: "Email",
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (value) {
                            _userEmail = value!;
                          },
                        ),
                        SizedBox(
                          height: tDefaultSize - 10,
                        ),

                        //Password
                        TextFormField(
                          key: ValueKey('password'),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return 'Pleas enter greater than 7';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.fingerprint_outlined),
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(
                                  () {
                                    passwordVisible = !passwordVisible;
                                  },
                                );
                              },
                            ),
                            hintText: "Greater than 7",
                            labelText: "Password",
                            border: OutlineInputBorder(),
                          ),
                          obscureText: passwordVisible,
                          onSaved: (value) {
                            _userPass = value!;
                          },
                        ),
                        SizedBox(
                          height: tDefaultSize - 10,
                        ),
                        if (widget.isLoading) CircularProgressIndicator(),

                        //BUTTON
                        if (!widget.isLoading)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(),
                                onPrimary: Colors.white,
                                primary: AppColors.tSecondaryColour,
                                side: BorderSide(
                                    color: AppColors.tSecondaryColour),
                                padding: EdgeInsets.symmetric(vertical: 15),
                              ),
                              onPressed: _trySubmit,
                              child: Text(_isLogin ? "LOGIN" : 'SIGNUP'),
                            ),
                          ),
                        SizedBox(
                          height: 20,
                        ),
                        if (!widget.isLoading)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 60),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: const Divider(
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        "OR",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      child: const Divider(
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  onPressed: () async {
                                    UserCredential? userCredential =
                                        await _signInWithGoogle();
                                    if (userCredential != null) {
                                      // Google Sign-In successful, navigate to the next screen
                                      Get.offAll(() => NavBar());
                                    } else {
                                      // Google Sign-In failed
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Failed to sign in with Google.'),
                                          backgroundColor:
                                              Theme.of(context).errorColor,
                                        ),
                                      );
                                    }
                                  },
                                  icon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Image(
                                      image:
                                          AssetImage("assets/googlelogo.png"),
                                      width: 28.0,
                                    ),
                                  ),
                                  label: const Text(
                                    "Sign-In with Google",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isLogin = !_isLogin;
                                  });
                                },
                                child: _isLogin
                                    ? Text.rich(
                                        TextSpan(
                                            text: "Don't have an Account?",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                            children: const [
                                              TextSpan(
                                                text: " SignUp",
                                                style: TextStyle(
                                                    color: Colors.deepPurple,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ]),
                                      )
                                    : Text.rich(
                                        TextSpan(
                                          text: "Already have an Account?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                          children: const [
                                            TextSpan(
                                              text: " SignIn",
                                              style: TextStyle(
                                                  color: Colors.deepPurple,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                              if (isLoadingIndicator) // Add this condition to show the circular progress indicator
                                const CircularProgressIndicator(),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        // Show circular progress indicator while signing in
        showCircularProgressIndicator();

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);

        final userRef = FirebaseFirestore.instance
            .collection('Users')
            .doc(userCredential.user!.uid);

        final userDoc = await userRef.get();
        if (!userDoc.exists) {
          // User document doesn't exist, add the data to Firestore
          await userRef.set({
            'email': userCredential.user!.email,
            'username': userCredential.user!.displayName,
            'userimage': defaultImageLogo,
          });
        }

        // Hide the circular progress indicator
        hideCircularProgressIndicator();

        return userCredential;
      }
    } catch (e) {
      print('Error signing in with Google: $e');
    }

    // Hide the circular progress indicator if an error occurs
    hideCircularProgressIndicator();

    return null;
  }

  void showCircularProgressIndicator() {
    // Update the UI to show the circular progress indicator
    // For example, you can set a boolean flag to control its visibility
    setState(() {
      isLoadingIndicator = true;
    });
  }

  void hideCircularProgressIndicator() {
    // Update the UI to hide the circular progress indicator
    // For example, you can set a boolean flag to control its visibility
    setState(() {
      isLoadingIndicator = false;
    });
  }
}

//
// import 'package:flutter/material.dart';
//
// class AuthForm extends StatefulWidget {
//   AuthForm(this.submitFn, this.isLoading);
//
//   final bool isLoading;
//   final void Function(
//       String email,
//       String password,
//       String username,
//       // File image,
//       bool isLogin,
//       BuildContext context,
//       ) submitFn;
//
//   @override
//   State<AuthForm> createState() => _AuthFormState();
// }
//
// class _AuthFormState extends State<AuthForm> {
//   bool passwordVisible=true;
//   final _formKey = GlobalKey<FormState>();
//   var _isLogin = true;
//   var _userEmail = '';
//   var _userName = '';
//   var _userPass = '';
//   // var _userImageFile;
//
//   // void _pickedImage(File image) {
//   //   _userImageFile = image;
//   // }
//
//   void _trySubmit() {
//     final isValid = _formKey.currentState!.validate();
//
//     //for keyboard lec 325
//     FocusScope.of(context).unfocus();
//
//     // if (_userImageFile == null && !_isLogin) {
//     //   Scaffold.of(context).showSnackBar(SnackBar(
//     //     content: Text("Please pick an image."),
//     //     backgroundColor: Theme.of(context).errorColor,
//     //   ));
//     //   return;
//     // }
//
//     if (isValid) {
//       _formKey.currentState!.save();
//       widget.submitFn(
//           _userEmail.trim(),
//           _userPass.trim(),
//           _userName.trim(),
//           // _userImageFile,
//           _isLogin,
//           context);
//
//       //use valeu to save data
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back_ios,
//             size: 20,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             if(_isLogin)
//               Column(
//                 children: <Widget>[
//                   Text(
//                     "Login",
//                     style: TextStyle(
//                         fontSize: 30, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text(
//                     "Login to your account",
//                     style: TextStyle(fontSize: 15, color: Colors.grey[700]),
//                   ),
//                 ],
//               ),
//             SizedBox(height: 40,),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 40),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // if (!_isLogin) UserImagePicker(_pickedImage),
//                     TextFormField(
//                       style:TextStyle(fontSize: 20),
//                       key: ValueKey('email'),
//                       autocorrect: false,
//                       textCapitalization: TextCapitalization.none,
//                       enableSuggestions: false,
//                       validator: (value) {
//                         if (value!.isEmpty || value.contains('*')) {
//                           return 'Pleas enter valid email address';
//                         } else {
//                           return null;
//                         }
//                       },
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: InputDecoration(
//
//                         prefixIcon: Icon(Icons.email),
//
//                         hintText: "abc@gmail.com",
//                         labelText: "Email Address",
//                         contentPadding:
//                         EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//                         enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey)),
//                         border: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey)),
//                       ),
//                       onSaved: (value) {
//                         _userEmail = value!;
//                       },
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     if (!_isLogin)
//                       TextFormField(
//                         style:TextStyle(fontSize: 20),
//                         key: ValueKey('username'),
//                         autocorrect: true,
//                         textCapitalization: TextCapitalization.words,
//                         enableSuggestions: false,
//                         validator: (value) {
//                           if (value!.isEmpty || value.length < 4) {
//                             return 'please enter more than 4';
//                           } else {
//                             return null;
//                           }
//                         },
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.person),
//                           labelText: "Username",
//                           contentPadding: EdgeInsets.symmetric(
//                               vertical: 0, horizontal: 10),
//                           enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey)),
//                           border: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey)),
//                         ),
//                         onSaved: (value) {
//                           _userName = value!;
//                         },
//                       ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     TextFormField(
//                       style:TextStyle(fontSize: 20),
//                       key: ValueKey('password'),
//                       validator: (value) {
//                         if (value!.isEmpty || value.length < 7) {
//                           return 'Pleas enter greater than 7';
//                         } else {
//                           return null;
//                         }
//                       },
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.lock),
//                         suffixIcon: IconButton(
//                           icon: Icon(passwordVisible
//                               ? Icons.visibility_off
//                               : Icons.visibility),
//                           onPressed: () {
//                             setState(
//                                   () {
//                                 passwordVisible = !passwordVisible;
//                               },
//                             );
//                           },
//                         ),
//
//                         hintText: "Greater than 7",
//                         labelText: "Password",
//                         contentPadding:
//                         EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//                         enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey)),
//                         border: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey)),
//                       ),
//                       obscureText: passwordVisible,
//                       onSaved: (value) {
//                         _userPass = value!;
//                       },
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     if (widget.isLoading) CircularProgressIndicator(),
//                     if (!widget.isLoading)
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 40),
//                         child: Container(
//                           padding: EdgeInsets.only(top: 3, left: 3),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(50),
//                             border: Border(
//                               bottom: BorderSide(color: Colors.black),
//                               top: BorderSide(color: Colors.black),
//                               left: BorderSide(color: Colors.black),
//                               right: BorderSide(color: Colors.black),
//                             ),
//                           ),
//                           child: MaterialButton(
//                             minWidth: double.infinity,
//                             height: 60,
//                             color: Colors.greenAccent,
//                             elevation: 5,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(50)),
//                             onPressed: _trySubmit,
//                             child: Text(_isLogin ? "LOGIN" : 'SIGNUP'),
//                           ),
//                         ),
//                       ),
//                     if (!widget.isLoading)
//                       FlatButton(
//                         textColor: Theme.of(context).primaryColor,
//                         onPressed: () {
//                           setState(() {
//                             _isLogin = !_isLogin;
//                           });
//                         },
//                         child: Text(_isLogin
//                             ? "Create new account"
//                             : 'I already have an account'),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height / 3,
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage('assets/background.png'),
//                       fit: BoxFit.cover)),
//             ),
//           ],
//
//         ),
//       ),
//     );
//   }
//
//
// }
