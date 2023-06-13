
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/UserModel.dart';
import 'package:food_delivery_app/screens/auth/home_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../config/helper/dialog_helper.dart';
import '../services/firebase_service.dart';
import '../services/storage_service.dart';
import '../services/store_service.dart';

class ProfileController extends GetxController {
  final firebaseUser = FirebaseAuth.instance.currentUser;
  Rx<String?> selectedGender = Rx<String?>(null);
  List<String> genders = ['Man', 'Woman', 'Other'];
  Rx<String?> birthDay = Rx<String?>(null);
  Rx<String?> fullName = Rx<String?>(null);
  Rx<String?> phoneNo = Rx<String?>(null);
  Rx<String?> address = Rx<String?>(null);
  Rx<String?> oldPassword = Rx<String?>(null);
  Rx<String?> newPassword = Rx<String?>(null);
  Rx<String?> reNewPassword = Rx<String?>(null);
  final FirebaseService _firebaseService = FirebaseService();
  final StorageService _storageService = StorageService();
  final storage = FirebaseStorage.instanceFor(bucket: 'gs://flutter-food-1a10d.appspot.com/');
  Rx<UserModel?> user = Rx<UserModel?>(null);
  final imagePicker = ImagePicker();
  var isLoading = true.obs;
  Rx<String?> photoUrl = Rx<String?>(null);
  Future pickGalleryImage(BuildContext context) async{
      if(!kIsWeb){
        final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
        if(pickedFile !=null){
          String downloadUrl;
          Reference referenceRoot = FirebaseStorage.instance.ref();
          Reference referenceDir = referenceRoot.child('avatars');
          Reference referenceToUpload =referenceDir.child('${DateTime.now().millisecondsSinceEpoch}.png');
          try{
            await referenceToUpload.putFile(File(pickedFile.path));
            downloadUrl = await referenceToUpload.getDownloadURL();
            _firebaseService.updateAvatar(downloadUrl);
            photoUrl.value = downloadUrl;
          }catch(e){
          }
        }else{
        }
      }
  }
  @override
  void onInit() async {
    if (firebaseUser != null) {
      isLoading(true);
      user.value = await loadUser(firebaseUser?.uid);
      selectedGender.value = user.value?.gender;
      birthDay.value = user.value?.birthDay;
      photoUrl.value = user.value?.photoUrl;
    }
    isLoading(false);
  }

  loadUser(String? uid) async {
    return await _firebaseService.getUserById(uid);
  }

  onSaveProfile(String? fullName, String? phoneNo, String? address,
      String? selectedGender, String? birthDay, String? email) async {
    DialogHelper.showLoading('Saving information');
    await _firebaseService.updateUser(UserModel(
      id: firebaseUser?.uid,
      fullName: fullName,
      email: email,
      phoneNo: phoneNo,
      address: address,
      birthDay: birthDay,
      gender: selectedGender,
    ));
    user.value = await loadUser(firebaseUser?.uid);
    DialogHelper.hideLoading();
    DialogHelper.alertDialog('Update Successful !');
  }
  changePassword(String email,String oldPassword,String newPassword) async{
    DialogHelper.showLoading('Changing Password');
    try {
      final firebaseUser = this.firebaseUser;
      if (firebaseUser != null) {
        final credential = EmailAuthProvider.credential(email: email, password: oldPassword);
        await firebaseUser.reauthenticateWithCredential(credential);
        await firebaseUser.updatePassword(newPassword);
        DialogHelper.hideLoading();
        DialogHelper.alertDialog('Password has been updated');
      } else {
        DialogHelper.hideLoading();
        DialogHelper.alertDialog('User information not found');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        DialogHelper.hideLoading();
        DialogHelper.alertDialog('Incorrect password');
      } else {
        DialogHelper.hideLoading();
        DialogHelper.alertDialog(e.message.toString());
        print(e.message);
      }
    } catch (e) {

      DialogHelper.hideLoading();
      DialogHelper.alertDialog(e.toString());
    }
  }
  signOut(){
    DialogHelper.showLoading('Signing out');
    _firebaseService.signOut();
    Get.offAllNamed(HomeScreen.routerName);
  }
}
