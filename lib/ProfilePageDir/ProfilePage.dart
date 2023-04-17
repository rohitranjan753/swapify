import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double coverHeight = 240;
  final double profileHeight = 144;
  @override
  Widget build(BuildContext context) {
    final top = coverHeight - profileHeight / 2;
    return Scaffold(
      body: SafeArea(
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
    );
    // return Scaffold(
    //   body: SafeArea(
    //     child: Column(
    //       children: [
    //         SizedBox(height: 60,),
    //         ElevatedButton(onPressed: (){
    //           FirebaseAuth.instance.signOut();
    //         }, child: Text('LOGOUT'),),
    //         Center(
    //           child:
    //           Text('Profile PAGE'),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.asset(
          'assets/profile/12.jpg',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: AssetImage(
            'assets/profile/user.png'),
      );

}
