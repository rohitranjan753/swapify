import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(image: AssetImage("assets/images/upload.png")),
            Column(
              children: [
                Text("Welcome to vBuddy",style: Theme.of(context).textTheme.headline3,),
                Text("Sell your belongings",style: Theme.of(context).textTheme.bodyText1,textAlign: TextAlign.center,),
              ],
            ),

            Row(
              children: [
                OutlineButton(onPressed: (){},
                child: Text("LOGIN"),),
                ElevatedButton(onPressed: (){}, child: Text("SIGNUP")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
