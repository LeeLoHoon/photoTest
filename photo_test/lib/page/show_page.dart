import 'package:flutter/material.dart';

class ShowPage extends StatefulWidget {
  @override
  ShowPageState createState() => ShowPageState();
}

class ShowPageState extends State<ShowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Example for photo manager."),
        ),
        body: StreamBuilder());
  }
}
