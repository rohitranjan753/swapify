import 'package:flutter/material.dart';
import 'package:vbuddyproject/Constants/sizes.dart';

class TLoginScreen extends StatelessWidget {
  const TLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage("assets/splash/splash.png"),
                  height: size.height * 0.2,
                ),
                Text(
                  "Welcome Back",
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  "Make it, take it, Risk it",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Form(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_outline_outlined),
                            labelText: "Email",
                            hintText: "Email Hint",
                            border: OutlineInputBorder()
                          ),
                        ),

                        TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_outline_outlined),
                              labelText: ,
                              hintText: "Email Hint",
                              border: OutlineInputBorder()
                          ),
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
}
