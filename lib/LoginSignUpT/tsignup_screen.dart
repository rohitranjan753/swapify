import 'package:flutter/material.dart';
import 'package:vbuddyproject/Constants/sizes.dart';
import 'package:vbuddyproject/LoginSignUpT/tlogin_screen.dart';

class TSignUpScreen extends StatelessWidget {
  const TSignUpScreen({Key? key}) : super(key: key);

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
                SignUpHeaderWidget(size: size),
                const SignUpForm(),
                const SignUpFooterWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class SignUpHeaderWidget extends StatelessWidget {
  const SignUpHeaderWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage("assets/splash/splash.png"),
          height: size.height * 0.2,
        ),
        Text(
          "Get On Board",
          style: Theme.of(context).textTheme.headline4,
        ),
        Text(
          "Connect with us!",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  labelText: "Username",
                  hintText: "Username Hint",
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 10,),
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  labelText: "Email",
                  hintText: "Email Hint",
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.fingerprint_outlined),
                  labelText: "Password",
                  hintText: "Password Hint",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: null,
                    icon: Icon(Icons.remove_red_eye_sharp),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("SIGNUP"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: Image(
              image: AssetImage("assets/googlelogo.png"),
              width: 20.0,
            ),
            label: Text("Sign-In with Google"),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>TLoginScreen()));
          },
          child: Text.rich(
            TextSpan(
                text: "Already have an Account?",
                style: Theme.of(context).textTheme.bodyText1,
                children: const [
                  TextSpan(
                    text: " SignIn",
                    style: TextStyle(color: Colors.blue),
                  ),
                ]),
          ),
        ),
      ],
    );
  }
}




