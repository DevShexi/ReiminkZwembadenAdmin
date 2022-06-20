import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reimink_zwembaden_admin/common/resources/colors.dart';
import 'package:reimink_zwembaden_admin/common/resources/strings.dart';

class ImagePickerUtility {
  Future<String?> picImageFromGallery() async {
    String? path;
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print(image.path);
      path = image.path;
    }
    return path;
  }

  Future<String?> picAndCropImageFromGalery() async {
    final String? cropedImagePath;
    final String? imagePath = await picImageFromGallery();
    if (imagePath != null) {
      final CroppedFile? cropedImage = await _cropPickedImage(imagePath);
      cropedImage != null
          ? cropedImagePath = cropedImage.path
          : cropedImagePath = null;
    } else {
      cropedImagePath = null;
    }
    return cropedImagePath;
  }

  Future<CroppedFile?> _cropPickedImage(String path) async {
    CroppedFile? cropedImage = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatio: const CropAspectRatio(
        ratioX: 5,
        ratioY: 7,
      ),
      aspectRatioPresets: [CropAspectRatioPreset.square],
      compressQuality: 70,
      compressFormat: ImageCompressFormat.jpg,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: Strings.cropImage,
          toolbarColor: AppColors.primary,
          toolbarWidgetColor: Colors.white,
        ),
        IOSUiSettings(
          title: Strings.cropImage,
        ),
      ],
    );
    return cropedImage;
  }
}
