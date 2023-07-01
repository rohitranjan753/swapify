import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vbuddyproject/Constants/image_string.dart';
import 'package:vbuddyproject/Constants/sizes.dart';
import 'package:vbuddyproject/Constants/text_string.dart';
import 'package:vbuddyproject/widget/back_btn_design.dart';

class AboutusScreen extends StatelessWidget {

  void _sendEmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: contactEmail,
      query:
      'subject=Hey%20Swapify%20team&body=Type%20your%20message%20',
    );
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  const AboutusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "ABOUT US",
          style: TextStyle(letterSpacing: textLetterSpacingValue),
        ),
        leading: backiconButtonDesign(),
        toolbarHeight: 60,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(swapifyLogo),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                aboutUsText,
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Version: ${versionText}",
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text("Contact Us:",style: TextStyle(
                      fontSize: 20
                  ),),
                  TextButton(onPressed: () {
                    _sendEmail();
                  }, child: Text(
                    contactEmail,style: TextStyle(
                      fontSize: 15
                  ),
                  ),


                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
