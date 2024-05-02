import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUpModel extends ChangeNotifier {
  File? _pickedImage;

  File? get pickedImage => _pickedImage;

  Future<void> pickImage(ImageSource source) async {
    try {
      final imagePicker = ImagePicker();
      final pickedImageFile = await imagePicker.pickImage(source: source);

      if (pickedImageFile != null) {
        _pickedImage = File(pickedImageFile.path);
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }
   void resetPickedImage() {
    _pickedImage = null;
    notifyListeners();
  }
}
