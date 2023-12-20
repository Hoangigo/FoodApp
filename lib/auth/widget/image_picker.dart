import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.pickImage});
  final void Function(File pickedImage) pickImage;

  @override
  State<UserImagePicker> createState() {
    return _UserImagePicker();
  }
}

class _UserImagePicker extends State<UserImagePicker> {
  File? pickImageFile;
  void _pickImage() async {
    final pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    if (pickedImage == null) return;
    setState(() {
      pickImageFile = File(pickedImage.path);
    });
    widget.pickImage(pickImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage:
              pickImageFile != null ? FileImage(pickImageFile!) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: const Text(
            'Add Image',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
