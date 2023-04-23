
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../screens/main_screen.dart';
class FirebaseService{
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  signInWithGoogle(context) async{
    try{
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if(googleSignInAccount != null){
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken
        );
        await _auth.signInWithCredential(authCredential);
        Navigator.of(context)
            .pushNamed(MainScreen.routerName);
      }
    }on FirebaseAuthException catch(e){
      print(e.message);
      throw e;
    }
  }
  Future<User?> signInWithEmailAndPassword(String emailAddress,String password,context) async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      Navigator.of(context)
          .pushNamed(MainScreen.routerName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return FirebaseAuth.instance.currentUser;
  }
  signOut() async{
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
  Future<bool> checkUserIsLogged() async {
    if (await _auth.currentUser! != null) {
      return true;
    }
    return false;
  }
}