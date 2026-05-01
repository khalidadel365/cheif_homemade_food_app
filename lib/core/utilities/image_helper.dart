import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static final ImagePicker _picker = ImagePicker();
  static Future<XFile?> pickImageWithChoice(BuildContext context) async {
    try {
      XFile? image;
      await showModalBottomSheet(
        context: context,
        builder:
            (context) => SafeArea(
              child: Wrap(
                children: [
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () async {
                      image = await _picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text('Camera'),
                    onTap: () async {
                      image = await _picker.pickImage(
                        source: ImageSource.camera,
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
      );

      return image;
    } catch (e) {
      print("Error picking image: $e");
      return null;
    }
  }
}
