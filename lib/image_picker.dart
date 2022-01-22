import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerSample extends StatefulWidget {
  const ImagePickerSample({Key? key}) : super(key: key);

  @override
  _ImagePickerSampleState createState() => _ImagePickerSampleState();
}

class _ImagePickerSampleState extends State<ImagePickerSample> {
  List<XFile> selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  void sample() async {
    for (var i = 0; i < selectedImages.length; i++) {
      // XFile file = selectedImages[i];
      // print(file.mimeType);
      // print(file.name);
      // print(file.path);
      // print(await file.readAsBytes());
      File image = File(selectedImages[i].path);
    }
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(selectedImages.length, (index) {
        File image = File(selectedImages[index].path);
        return Image.file(image);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('image_picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: pickerImage,
              child: const Text('image_picker'),
            ),
            Expanded(
              child: buildGridView(),
            ),
            ElevatedButton(
              onPressed: pickVideo,
              child: const Text('video pick'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickVideo() async {
    final XFile? file = await _picker.pickVideo(source: ImageSource.gallery);
  }

  Future<void> pickerImage() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    setState(() {
      selectedImages = images!;
    });
    sample();
  }
}
