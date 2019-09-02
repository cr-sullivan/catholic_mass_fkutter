import 'package:flutter/material.dart';

void main() => runApp(GHFlutterApp());


class GHFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catholic Mass Auckland',
      home: GHFlutter(),
    );
  }
}

class GHFlutterState extends State<GHFlutter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text('Catholic Mass Auckland'),
      ),
      body: Text('God Bless'),
    );
  }
}

class GHFlutter extends StatefulWidget {
  @override
  createState() => GHFlutterState();
}
