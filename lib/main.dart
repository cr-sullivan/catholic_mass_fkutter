//https://www.raywenderlich.com/4529993-getting-started-with-flutter

// Next:  Navigation:
//https://www.raywenderlich.com/4562634-flutter-navigation-getting-started

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(CatholicMassAucklandApp());


class CatholicMassAucklandApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catholic Mass Auckland 1',
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
        title: Text('Catholic Mass Auckland 1'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info),
            tooltip: 'Show Information',
            onPressed: () {
              _showInfoDialog();
            },
          ),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Next page',
            onPressed: () {
              //openPage(context);
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
        final member = Parish(memberJSON["login"], memberJSON["avatar_url"]);
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
        )
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('About'),
          content: Text('Catholic Mass Auckland.  Flutter.  V0.001'),
        );
      }
    );
  }



}

class Parish {
  final String login;
  final String avatarUrl;

  Parish(this.login, this.avatarUrl) {
    if (login == null) {
      throw ArgumentError("login of Member cannot be null. "
          "Received: '$login'");
    }
    if (avatarUrl == null) {
      throw ArgumentError("avatarUrl of Member cannot be null. "
          "Received: '$avatarUrl'");
    }
  }
}
