import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:harbour/pages/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:video_player/video_player.dart';

import '../../../../../tools/navigation.dart';
import '../../../../home_page.dart';
import '../../../../global/common/toast.dart';
import '../../firebase_auth_implementation/firebase_auth_services.dart';
import '../widgets/form_container_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late VideoPlayerController _videoPlayerController;
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(
      'assets/launch/signin.mp4',
    )..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
        _videoPlayerController.setVolume(0.0);
        _videoPlayerController.setLooping(true);
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.transparent,
      //   title: Text(""),
      // ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: _videoPlayerController.value.isInitialized
                          ? AspectRatio(
                              aspectRatio:
                                  _videoPlayerController.value.aspectRatio,
                              child: VideoPlayer(_videoPlayerController),
                            )
                          : Container(),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 27, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          FormContainerWidget(
                            controller: _emailController,
                            hintText: "Email",
                            isPasswordField: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FormContainerWidget(
                            controller: _passwordController,
                            hintText: "Password",
                            isPasswordField: true,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              _signIn();
                            },
                            child: Container(
                              width: 250,
                              height: 45,
                              margin: const EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: _isSigning
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        "Login",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
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
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.google,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
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
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpPage()),
                                    (route) => false,
                                  );
                                },
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      showToast(message: "We're taking you in");
      if (mounted) {
        goTo(
            const MyHomePage(
              title: '',
            ),
            context);
      } // Navigator.pushNamed(context, "/home");//"/home");
    } else {
      showToast(message: "some error occured");
    }
  }

  _signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
        // clientId:
        );
    // "308935094536-84ag5jk3r36pkch5r7bcbq56c1mpvr6k.apps.googleusercontent.com");
    // "1091454301447-9j9tlbl8qir77v62g5sjqmlhjmislghm.apps.googleusercontent.com");//old
    // "1091454301447-uqas381p5bguc2mb144117imjhvf0jni.apps.googleusercontent.com");

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _firebaseAuth.signInWithCredential(credential);
        var username = googleSignInAccount.displayName;if(mounted){
        jumpTo(MyHomePage(title: "Welcome $username"), context);}
      }
    } catch (e) {
      showToast(message: "some error occurred $e");
      // print("======================================================");
      // print(e);
    }
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:harbour/pages/features/user_auth/presentation/pages/sign_up_page.dart';
// import 'package:video_player/video_player.dart';
//
// import '../../../../../tools/navigation.dart';
// import '../../../../home_page.dart';
// import '../../../../global/common/toast.dart';
// import '../../firebase_auth_implementation/firebase_auth_services.dart';
// import '../widgets/form_container_widget.dart';
//
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage>
//     with SingleTickerProviderStateMixin {
//   late VideoPlayerController _videoPlayerController;
//   bool _isSigning = false;
//   final FirebaseAuthService _auth = FirebaseAuthService();
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _videoPlayerController = VideoPlayerController.asset(
//       'assets/launch/signin.mp4', // Replace with your video asset path
//     )..initialize().then((_) {
//       setState(() {});
//       _videoPlayerController.play(); // Autoplay
//       _videoPlayerController.setVolume(0.0); // Mute video
//       _videoPlayerController.setLooping(true); // Loop video
//     });
//   }
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text("Login"),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Login",
//                 style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               FormContainerWidget(
//                 controller: _emailController,
//                 hintText: "Email",
//                 isPasswordField: false,
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               FormContainerWidget(
//                 controller: _passwordController,
//                 hintText: "Password",
//                 isPasswordField: true,
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   _signIn();
//                 },
//                 child: Container(
//                   width: 250,
//                   height: 45,
//                   margin: const EdgeInsets.only(bottom: 20),
//                   decoration: BoxDecoration(
//                     color: Colors.deepPurple,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 // child: Container(
//                 //   width: double.infinity,
//                 //   height: 45,
//                 //   decoration: BoxDecoration(
//                 //     color: Colors.blue,
//                 //     borderRadius: BorderRadius.circular(10),
//                 //   ),
//                   child: Center(
//                     child: _isSigning ? CircularProgressIndicator(
//                       color: Colors.white,) : Text(
//                       "Login",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10,),
//               GestureDetector(
//                 onTap: () {
//                   _signInWithGoogle();
//                 },
//                 // child: Container(
//                 //   width: double.infinity,
//                 //   height: 45,
//                 //   decoration: BoxDecoration(
//                 //     color: Colors.red,
//                 //     borderRadius: BorderRadius.circular(10),
//                 //   ),
//                 child: Container(
//                   width: 250,
//                   height: 45,
//                   margin: const EdgeInsets.only(bottom: 20),
//                   decoration: BoxDecoration(
//                     color: Colors.red,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(FontAwesomeIcons.google, color: Colors.white,),
//                         SizedBox(width: 5,),
//                         Text(
//                           "Sign in with Google",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//
//
//               SizedBox(
//                 height: 20,
//               ),
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Don't have an account?"),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(builder: (context) => SignUpPage()),
//                             (route) => false,
//                       );
//                     },
//                     child: Text(
//                       "Sign Up",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _signIn() async {
//     setState(() {
//       _isSigning = true;
//     });
//
//     String email = _emailController.text;
//     String password = _passwordController.text;
//
//     User? user = await _auth.signInWithEmailAndPassword(email, password);
//
//     setState(() {
//       _isSigning = false;
//     });
//
//     if (user != null) {
//       showToast(message: "We're taking you in");
//       goTo(MyHomePage(title: '',), context);
//       // Navigator.pushNamed(context, "/home");//"/home");
//     } else {
//       showToast(message: "some error occured");
//     }
//   }
//
//   _signInWithGoogle() async {
//     final GoogleSignIn _googleSignIn = GoogleSignIn(
//       // clientId:
//     );
//     // "308935094536-84ag5jk3r36pkch5r7bcbq56c1mpvr6k.apps.googleusercontent.com");
//     // "1091454301447-9j9tlbl8qir77v62g5sjqmlhjmislghm.apps.googleusercontent.com");//old
//     // "1091454301447-uqas381p5bguc2mb144117imjhvf0jni.apps.googleusercontent.com");
//
//     try {
//       final GoogleSignInAccount? googleSignInAccount =
//       await _googleSignIn.signIn();
//
//       if (googleSignInAccount != null) {
//         final GoogleSignInAuthentication googleSignInAuthentication =
//         await googleSignInAccount.authentication;
//
//         final AuthCredential credential = GoogleAuthProvider.credential(
//           idToken: googleSignInAuthentication.idToken,
//           accessToken: googleSignInAuthentication.accessToken,
//         );
//
//         await _firebaseAuth.signInWithCredential(credential);
//         var username = googleSignInAccount.displayName;
//         jumpTo(MyHomePage(title: "Welcome $username"), context);
//       }
//     } catch (e) {
//       showToast(message: "some error occurred $e");
//       print("======================================================");
//       print(e);
//     }
//   }
// }
//
// //   _signInWithGoogle()async{
// //
// //     final GoogleSignIn _googleSignIn = GoogleSignIn();
// //
// //     try {
// //
// //       final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
// //
// //       if(googleSignInAccount != null ){
// //         final GoogleSignInAuthentication googleSignInAuthentication = await
// //         googleSignInAccount.authentication;
// //
// //         final AuthCredential credential = GoogleAuthProvider.credential(
// //           idToken: googleSignInAuthentication.idToken,
// //           accessToken: googleSignInAuthentication.accessToken,
// //         );
// //
// //         await _firebaseAuth.signInWithCredential(credential);
// //         Navigator.pushNamed(context, "/home");
// //       }
// //
// //     }catch(e) {
// // showToast(message: "some error occured $e");
// //     }
// //
// //
// //   }
//
//
// // }