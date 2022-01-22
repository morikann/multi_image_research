import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class MultiImagePickerSample extends StatefulWidget {
  const MultiImagePickerSample({Key? key}) : super(key: key);

  @override
  _MultiImagePickerSampleState createState() => _MultiImagePickerSampleState();
}

class _MultiImagePickerSampleState extends State<MultiImagePickerSample> {
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('multi_image_picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Center(child: Text('Error: $_error')),
            ElevatedButton(
              onPressed: loadAssets,
              child: const Text('multi_image_picker'),
            ),
            Expanded(
              child: buildGridView(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        materialOptions: const MaterialOptions(
          allViewTitle: "画像選択",
          startInAllView: true,
          textOnNothingSelected: '画像なし',
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    print(resultList); //=> [Instance of 'Asset', Instance of 'Asset']
    print(resultList[0].name); //=> IMG_2292.JPG
    print(resultList[0]
        .identifier); //=> 125B4DEA-40D5-4502-944B-66236BFEF887/L0/001

    setState(() {
      images = resultList;
      _error = error;
    });
  }
}
