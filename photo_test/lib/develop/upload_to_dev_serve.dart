import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:photo_manager/photo_manager.dart';

class UploadToDevServer {
//  FirebaseApp app = FirebaseApp.instance;
  FirebaseStorage storage = FirebaseStorage(
      app: FirebaseApp.instance,
      storageBucket: 'gs://testing-58871.appspot.com');

  upload(AssetEntity entity) async {
//    print('@@@@@@@@@@@');

    final data = await entity.originBytes;
//    print('@@@@@@@@@@@' + data.toString());
    final String rand = "${Random().nextInt(10000)}";
    final StorageReference ref =
        storage.ref().child('test').child('${entity.createDateTime}');

    final StorageUploadTask uploadTask = ref.putData(
      data,
    );

    await (await uploadTask.onComplete)
        .ref
        .getDownloadURL()
        .then((dynamic url) {
      print(url);
    });
  }
}
