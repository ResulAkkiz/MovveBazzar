import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_1/services/storage_base.dart';

class FirebaseStorageService implements StorageBase {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  late Reference _storageRef;
  @override
  Future<String> uploadFile(
      String userID, String fileType, File uploadedFile) async {
    _storageRef = _firebaseStorage
        .ref()
        .child(userID)
        .child(fileType)
        .child("Profile_photo.png");

    UploadTask uploadTask = _storageRef.putFile(uploadedFile);
    var url = await (await uploadTask).ref.getDownloadURL();
    return url;
  }
}
