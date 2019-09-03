//https://www.raywenderlich.com/4529993-getting-started-with-flutter

// Next:  Navigation:
//https://www.raywenderlich.com/4562634-flutter-navigation-getting-started

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:catholic_mass/Parish.dart';
import 'package:catholic_mass/ParishWidget.dart';

String appTitle = 'Catholic Mass Auckland 0.001';

String details = 'Some details for the parish.\r\n' +
    'Regular Masses on Sudays.\r\n' +
    'Parish Priest: Fr Sherwin Lapaan';

void main() => runApp(CatholicMassAucklandApp());


class CatholicMassAucklandApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(primaryColor: Colors.green.shade800),
      home: CatholicMassAuckland(),
    );
  }
}

class CatholicMassAuckland extends StatefulWidget {
  @override
  createState() => CatholicMassAucklandState();
}

class CatholicMassAucklandState extends State<CatholicMassAuckland> {
  var _parishes = <Parish>[];

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info),
            tooltip: 'Show Information',
            onPressed: () {
              _showInfoDialog();
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: _parishes.length * 2,
          itemBuilder: (BuildContext context, int position) {
            if (position.isOdd) return Divider();

            final index = position ~/ 2;

            return _buildRow(index);
          }),
    );
  }

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  _loadData() async {
    String dataURL = "https://api.github.com/orgs/raywenderlich/members";
    http.Response response = await http.get(dataURL);
    setState(() {
      final membersJSON = json.decode(response.body);

      for (var memberJSON in membersJSON) {
        final member = Parish(memberJSON["login"], memberJSON["avatar_url"],
            details);
        _parishes.add(member);
      }
    });
  }

  Widget _buildRow(int i) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListTile(
          title: Text("${_parishes[i].login}", style: _biggerFont),
          leading: CircleAvatar(
              backgroundColor: Colors.green,
              backgroundImage: NetworkImage(_parishes[i].avatarUrl)
          ),
          onTap: () {
            _pushMember(_parishes[i]);
          },
        )
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(appTitle),
          content: Text('Flutter.\r\nwww.sullivanapps.co.nz'),
        );
      }
    );
  }

  _pushMember(Parish parish) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ParishWidget(parish)));
  }

}


