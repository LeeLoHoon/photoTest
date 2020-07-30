import 'package:flutter/material.dart';
import 'package:photo_test/page/show_page.dart';

import 'home_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example for photo manager."),
      ),
      body: ListView(
        children: <Widget>[
          routePage("gallery list", NewHomePage()),
          routePage("gallery list", ShowPage()),
        ],
      ),
    );
  }

  Widget routePage(String title, Widget page) {
    return RaisedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return page;
            },
          ),
        );
      },
      child: Text(title),
    );
  }
}
