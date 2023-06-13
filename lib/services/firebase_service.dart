import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/auth/home_screen.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../config/helper/local_storage_helper.dart';
import '../models/UserModel.dart';
import '../screens/main_screen.dart';
import 'package:intl/intl.dart';
class FirebaseService {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  final _googleSignIn = GoogleSignIn();

  // @override
  // void onReady() {
  //   Future.delayed(const Duration(seconds: 3));
  //   firebaseUser = Rx<User?>(_auth.currentUser);
  //   firebaseUser.bindStream(_auth.userChanges());
  //   // ever(firebaseUser, _setInitialScreen);
  // }

  // _setInitialScreen(User? user) {
  //   user == null
  //       ? Get.offAll(() => HomeScreen())
  //       : Get.offAll(() => MainScreen());
  // }

  signInWithGoogle(context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await _auth.signInWithCredential(authCredential);
        await saveUser(googleSignInAccount, _auth);
        Get.offAndToNamed(MainScreen.routerName);
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String emailAddress, String password, context) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      print('SignIn Success.');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return FirebaseAuth.instance.currentUser;
  }

  signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  Future<FirebaseAuthException?> createUserWithEmailAndPassword(
      String emailAddress, String password, String fullName) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      final dayNow = DateFormat('yyyy/MM/dd').format(DateTime.now());
      await _auth.currentUser?.updateDisplayName(fullName);
      await _fireStore.collection('users').doc(_auth.currentUser?.uid).set({
        'fullName': fullName,
        'email': emailAddress,
        'photoUrl': null,
        'phoneNo': null,
        'password': null,
        'role': false,
        'create_at': dayNow
      });
      return null;
    } on FirebaseAuthException catch (e) {
      return e;
    } catch (e) {
      throw (e);
    }
  }

  Future<bool> checkUserIsLogged() async {
    if (_auth.currentUser != null) {
      return true;
    }
    return false;
  }

  saveUser(GoogleSignInAccount googleSignInAccount, FirebaseAuth auth) {
    _fireStore.collection('users').doc(auth.currentUser?.uid).update({
      'fullName': googleSignInAccount.displayName,
      'email': googleSignInAccount.email,
      'photoUrl': googleSignInAccount.photoUrl,
      'phoneNo': null,
      'password': null,
      'role': false
    });
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future updateUser(UserModel userModel) async {
    try {
      if(_auth.currentUser?.email != userModel.email){
        await _auth.currentUser?.updateDisplayName(userModel.fullName);
      }
      await _fireStore
          .collection('users')
          .doc(userModel.id)
          .update({
        'fullName': userModel.fullName,
        'email': userModel.email,
        'phoneNo': userModel.phoneNo,
        'address': userModel.address,
        'birthDay': userModel.birthDay,
        'gender': userModel.gender,
      });
      print('User updated successfully!');
    } catch (e) {
      print('Error updating user: $e');
    }
  }
  Future<UserModel> getUserById(String? id) async {
    final DocumentSnapshot doc = await _fireStore.collection('users').doc(id).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    } else {
      throw Exception('User not found!');
    }
  }
  Future updateAvatar(String photoUrl) async {
    try {
      await _auth.currentUser?.updatePhotoURL(photoUrl);
      await _fireStore
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .update({
        'photoUrl': photoUrl,
      });
      print('User updated successfully!');
    } catch (e) {
      print('Error updating user: $e');
    }
  }
}
