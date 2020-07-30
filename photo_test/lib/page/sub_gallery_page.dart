import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class SubFolderPage extends StatefulWidget {
  @override
  _SubFolderPageState createState() => _SubFolderPageState();
}

class _SubFolderPageState extends State<SubFolderPage> {
  FirebaseStorage storage = FirebaseStorage(
      app: FirebaseApp.instance,
      storageBucket: 'gs://testing-58871.appspot.com');

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
          body: ListView(
        children: <Widget>[
          FutureBuilder(
              future: _buildItem(),
              builder: (context, snapshot) {
                return Image.memory(
                  snapshot.data,
                  fit: BoxFit.cover,
                );
              }),
          FutureBuilder(
              future: _buildItem2(),
              builder: (context, snapshot) {
                return Image.memory(
                  snapshot.data,
                  fit: BoxFit.cover,
                );
              }),
        ],
      ));
    } catch (e) {
      print(e);
      return Container();
    }
  }

  Future<dynamic> _buildItem() async {
    try {
      final data = await storage
          .ref()
          .child('test')
          .child('2020-07-29 19:52:02.000')
          .getData(1000000000);
      print('@@@@@@@@' + data.toString());
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> _buildItem2() async {
    try {
      final data = await storage
          .ref()
          .child('test')
          .child('2020-07-29 19:52:02_200x200.000')
          .getData(1000000000);
      print('@@@@@@@@' + data.toString());
      return data;
    } catch (e) {
      print(e);
    }
  }
}
