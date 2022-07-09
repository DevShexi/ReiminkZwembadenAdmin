import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageUtils {
  StorageUtils({required this.storageInstance});
  final FirebaseStorage storageInstance;
  Future<String?> uploadImageToStorage(File image) async {
    String? downloadUrl;
    final storageRef = storageInstance.ref();
    final iconRef = storageRef.child(
      DateTime.now().toString(),
    );
    try {
      await iconRef.putFile(image);
      downloadUrl = await iconRef.getDownloadURL();
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }
    return downloadUrl;
  }

  Future<void> deleteImageFromStorage(String url) async {
    try {
      await storageInstance.refFromURL(url).delete();
    } on FirebaseException catch (e) {
      debugPrint("Could not Delete the image from storage: $e");
    }
  }
}
