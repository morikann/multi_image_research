import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:multi_image_research/wechat_assets_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class WechatAssetsPickerSample extends StatefulWidget {
  const WechatAssetsPickerSample({Key? key}) : super(key: key);

  @override
  _WechatAssetsPickerSampleState createState() =>
      _WechatAssetsPickerSampleState();
}

class _WechatAssetsPickerSampleState extends State<WechatAssetsPickerSample> {
  List<AssetEntity> selectedImages = [];

  con(AssetEntity entity) async {
    File? file = await entity.file;
    print(
        file); //=> File: '/private/var/mobile/Containers/Data/Application/02EBA398-E283-4FC3-8894-41A87B05387C/tmp/flutter-images/433cb0a873f10f79e5576a8b38e7f751_exif.jpg'
    final Uint8List byteData = await file!.readAsBytes();
    print(byteData); //=> [255, 216, 255, 224, 0, 16, 74, 70, ...]
    print(entity.title); //=> IMG_2295.JPG
    print(await entity
        .thumbData); //=> File: '/private/var/mobile/Containers/Data/Application/02EBA398-E283-4FC3-8894-41A87B05387C/tmp/flutter-images/8cc7236be44c215ef3ca7deaa9ddb826_exif.jpg'
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(selectedImages.length, (index) {
        AssetEntity entity = selectedImages[index];
        con(entity);
        return Image(
          image: AssetEntityImageProvider(
            entity,
            // thumbSize: [300, 300],
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('wechat_assets_picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                List<AssetEntity>? images = await AssetPicker.pickAssets(
                  context,
                  maxAssets: 5,
                  textDelegate: JapaneseTextDelegate(),
                  // gridCount: 3,
                  // pageSize: 30,
                  gridThumbSize: 800,
                  pathThumbSize: 200,
                  // requestType: RequestType.video,
                  // themeColor: Colors.yellow,
                );
                setState(() {
                  selectedImages = images!;
                });
              },
              child: const Text('wechat_assets_picker'),
            ),
            Expanded(child: buildGridView()),
          ],
        ),
      ),
    );
  }
}
