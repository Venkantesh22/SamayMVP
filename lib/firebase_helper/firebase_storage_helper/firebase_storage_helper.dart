import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:samay_mvp/models/user_model/user_model.dart';

class FirebaseStorageHelper {
  static FirebaseStorageHelper instance = FirebaseStorageHelper();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //upload Profile Image
  Future<String> uploadUserImage(
      File image, String userID, String imageName) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    TaskSnapshot taskSnapshot = await _storage
        .ref("UserProfileImages/$userID/$imageName.jpg")
        .putFile(image, SettableMetadata(contentType: 'image/jpeg'));
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }

  //upload Profile Image
  Future<String> updateProfileImage(
      File newImagePath, String oldImageUrl, UserModel userModel) async {
    // First, delete the old image if it exists
    if (oldImageUrl.isNotEmpty) {
      await deleteImageFromFirebase(oldImageUrl);
    }

    // Then upload the new image

    String imageUrl =
        await uploadUserImage(newImagePath, userModel.id, userModel.name);

    return imageUrl;
  }

  //delete image from firebase\
  Future<void> deleteImageFromFirebase(String imageUrl) async {
    try {
      // Create a reference to the file to delete
      final storageRef = FirebaseStorage.instance.refFromURL(imageUrl);

      // Delete the file
      await storageRef.delete();

      print("Image deleted successfully");
    } catch (e) {
      print("Error occurred while deleting the image: $e");
    }
  }
}
