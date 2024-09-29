import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Googlesignin extends StatefulWidget {
  const Googlesignin({super.key});




  @override
  State<Googlesignin> createState() => _GooglesigninState();
}

class _GooglesigninState extends State<Googlesignin> {

  Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  var d = await FirebaseAuth.instance.signInWithCredential(credential);

  Map<String,dynamic>? userdata = d.additionalUserInfo?.profile;

  if(userdata!=null){
    var first_name = userdata["given_name"];
    var last_name = userdata["family_name"];
    var email = userdata["email"];
    var imgurl = userdata["picture"];




  }

  return d;
}


  Future<UserCredential?> _signInWithGoogle() async {
    try {
      // await InternetAddress.lookup('google.com');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print('SignInFailed $e');
      throw Exception('SignInFailed $e');
    }
  }

  @override
  void initState() {
      super.initState();
      signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}