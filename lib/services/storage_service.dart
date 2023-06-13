
import 'dart:io';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:food_delivery_app/config/helper/dialog_helper.dart';
import 'package:image_picker/image_picker.dart';

import 'firebase_service.dart';
class StorageService{
  final FirebaseService _firebaseService = FirebaseService();
  final storage = FirebaseStorage.instanceFor(bucket: 'gs://flutter-food-1a10d.appspot.com/');
  Future<void> uploadImageToFirebaseStorage(File? file,Uint8List? data) async {
    String? downloadUrl;
    if(!kIsWeb){
      final Reference storageRef = storage.ref().child('avatars/${DateTime.now().millisecondsSinceEpoch}.png');
      final TaskSnapshot uploadTask = await storageRef.putFile(file!);
      downloadUrl = await uploadTask.ref.getDownloadURL();
      _firebaseService.updateAvatar(downloadUrl);
    }else{
      final Reference storageRef = storage.ref().child('avatars/${DateTime.now().millisecondsSinceEpoch}.png');
      final uploadTask = await storageRef.putData(data!);
      downloadUrl = await uploadTask.ref.getDownloadURL();
    }
  }
}