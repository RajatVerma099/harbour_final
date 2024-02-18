import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:harbour/pages/home_page.dart';
import 'package:harbour/tools/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:video_player/video_player.dart';
import '../../../../global/common/toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoPlayerController;
  bool _isSigning = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(
      'assets/launch/signin.mp4', // Replace with your video asset path
    )..initialize().then((_) {
      setState(() {});
      _videoPlayerController.play(); // Autoplay
      _videoPlayerController.setVolume(0.0); // Mute video
      _videoPlayerController.setLooping(true); // Loop video
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          _videoPlayerController.value.isInitialized
              ? AspectRatio(
            aspectRatio: width/height,
            child: VideoPlayer(_videoPlayerController),
          )
              : Container(), // Placeholder for video
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: 0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Spacer to push the button to the center of the screen
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      _signInWithGoogle();
                    },
                    child: Container(
                      width: 250,
                      height: 45,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.google, color: Colors.white),
                            SizedBox(width: 5),
                            Text(
                              "Sign in with Google",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn(
        // clientId:
    );
        // "308935094536-84ag5jk3r36pkch5r7bcbq56c1mpvr6k.apps.googleusercontent.com");
        // "1091454301447-9j9tlbl8qir77v62g5sjqmlhjmislghm.apps.googleusercontent.com");//old
    // "1091454301447-uqas381p5bguc2mb144117imjhvf0jni.apps.googleusercontent.com");

    try {
      final GoogleSignInAccount? googleSignInAccount =
      await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _firebaseAuth.signInWithCredential(credential);
        var username = googleSignInAccount.displayName;
        jumpTo(MyHomePage(title: "Welcome $username"), context);
      }
    } catch (e) {
      showToast(message: "some error occurred $e");
      print("======================================================");
      print(e);
    }
  }
}
