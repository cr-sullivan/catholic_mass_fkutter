import 'package:flutter/material.dart';
import 'package:catholic_mass/Parish.dart';

class ParishState extends State<ParishWidget> {
  final Parish parish;

  ParishState(this.parish);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(parish.login),
        ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(children: [
              Image.network(parish.avatarUrl),
              Text(parish.details),
            ], ),
        ),
    );
  }
}

class ParishWidget extends StatefulWidget {
  final Parish parish;

  ParishWidget(this.parish) {
    if (parish == null) {
      throw ArgumentError(
          "parish of MemberWidget cannot be null. Received: '$parish'");
    }
  }

  @override
  createState() => ParishState(parish);
}