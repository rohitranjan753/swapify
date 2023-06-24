import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icon.dart';
import 'package:vbuddyproject/ProfilePageDir/Editing/all_listing.dart';
import 'package:vbuddyproject/ProfilePageDir/Editing/editprofile_screen.dart';
import 'package:vbuddyproject/ProfilePageDir/setting_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  String username = '';
  String email = '';
  String userImage = '';
  void getData() async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;

    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    setState(() {
      username = userDoc.get('username');
      email = userDoc.get('email');
      userImage = userDoc.get('userimage');
    });
  }

  final double coverHeight = 240;
  final double profileHeight = 144;
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    final top = coverHeight - profileHeight / 2;
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  buildCoverImage(),
                  Positioned(
                    top: top,
                    child: buildProfileImage(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Text(
              username,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              email,
              style: TextStyle(fontSize: 25, color: Colors.grey),
            ),
            SizedBox(
              height: 40,
            ),
            // MaterialButton(
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => EditprofileScreen()));
            //   },
            //   elevation: 20,
            //   minWidth: myWidth * 0.5,
            //   height: myHeight * 0.06,
            //   color: Colors.amber[300],
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(50)),
            //   child: Text(
            //     'EDIT PROFILE',
            //     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            //   ),
            // ),
            ProfileMenuWidget(
              title: "Edit Profile",
              icon: Icons.person,
              onPress: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>EditprofileScreen()));
              },
              textColor: Colors.black,
            ),
            // SizedBox(
            //   height: 30,
            // ),
            ProfileMenuWidget(
              title: "Edit Listing",
              icon: Icons.edit,
              onPress: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AllListing()));
              },
              textColor: Colors.black,
            ),
            ProfileMenuWidget(
              title: "Settings",
              icon: Icons.settings,
              onPress: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreen()));
              }, textColor: Colors.black,
            ),

          ],
        ),
      ),
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.asset(
          'assets/profile_background.jpg',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: NetworkImage(userImage),
      );
}

class ProfileMenuWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color textColor;

  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 300,
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.indigoAccent.withOpacity(0.2),
            ),
            child: Icon(
              icon,
              color: Colors.deepPurple,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          trailing: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.2),
              ),
              child: Icon(Icons.arrow_forward_ios_outlined),
            ),

        ),
      ),
    );
  }
}
