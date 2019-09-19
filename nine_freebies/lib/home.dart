// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'color_loader_2.dart';
import 'utils.dart';
import 'invitation.dart';

//Color blue1 = Color(0xff01b2ff);
//Color blue2 = Color(0xffb1e4ff);
//Color blue3 = Color(0xff719db9);
//Color blue4 = Color(0xff01b2ff);
//Color blue5 = Color(0xffbfd3df);

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to NineFreebies',
      home: RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final _freebies = <Freebie>[];
  final _jumboWhiteFont = const TextStyle(fontSize: 36.0, color: Colors.white);
  final _bigWhiteFont = const TextStyle(fontSize: 24.0, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/nine_freebies_logo.png'),
        backgroundColor: new Color(0xff1b2d36),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      body: _container(),
    );
  }

  Widget _container() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
              decoration: const BoxDecoration(color: Color(0xff01b2ff)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Expanded(
                    child: Stack(children: <Widget>[
                      new Positioned(
                        child: ColorLoader2(
                          color1: Colors.white,
                          color2: Colors.white,
                          color3: Colors.white,
                        ),
                      ),
                      new Positioned(
                        left: 35.0,
                        top: 30.0,
                        child: Text(
                          '-LEVEL-',
                          style: TextStyle(color: Colors.white, fontSize: 10.0),
                        ),
                      ),
                      new Positioned(
                        left: 40.0,
                        top: 35.0,
                        child: Text(
                          '1',
                          style: _jumboWhiteFont,
                        ),
                      )
                    ]),
                    flex: 3,
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Container(),
                        ),
                        Expanded(
                          child: Text(
                            'Nancy',
                            style: _jumboWhiteFont,
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          child: Text(
                            'Drew',
                            style: _bigWhiteFont,
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(),
                        ),
                      ],
                    ),
                    flex: 5,
                  )
                ],
              )),
          flex: 2,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(color: Color(0xffb1e4ff)),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => InvitationLoadingPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.loyalty,
                    color: Colors.white,
                    size: 50.0,
                  ),
                  Text('Find Freebies', style: _jumboWhiteFont),
                  ],
                ),
            )
          ),
          flex: 1,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: _buildSuggestions(),
          ),
          flex: 3,
        ),
      ],
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _freebies.length) {
            _freebies.add(new Freebie(
                "It's Pizza Time", "12/11/2099", Icons.local_pizza));
            _freebies.add(new Freebie("Scooby Snacks", "N/A", Icons.pets));
            _freebies.add(new Freebie(
                "Back-to-School Stationery", "12/11/2099", Icons.school));
            _freebies.add(new Freebie(
                "Smart Home Lights", "16/04/2020", Icons.wb_incandescent));
            _freebies
                .add(new Freebie("BBQ Firestarters", "N/A", Icons.whatshot));
          }
          return _buildRow(_freebies[index].description,
              _freebies[index].expiry, _freebies[index].icon);
        });
  }

  Widget _buildRow(String description, String expiry, IconData iconData) {
    return ListTile(
      leading: Icon(
        iconData,
        size: 30.0,
      ),
      title: Text(
        description,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        'Expires: ' + expiry,
        style: TextStyle(
            fontStyle: FontStyle.italic, color: Colors.grey, fontSize: 12.0),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class Freebie {
  String description;
  String expiry;
  IconData icon;

  Freebie(String description, String expiry, IconData iconData) {
    this.description = description;
    this.expiry = expiry;
    this.icon = iconData;
  }
}

class InvitationLoadingPage extends StatefulWidget {
  @override
  _InvitationLoadingPageState createState() => _InvitationLoadingPageState();
}

class _InvitationLoadingPageState extends State<InvitationLoadingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((__) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => InvitationPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexToColor("#1b2d36"),
      body: Center(
        child: Container(
          color: hexToColor("#1b2d36"),
          child: ColorLoader2 (
          color1: Colors.lightBlueAccent,
          color2: Colors.redAccent,
          color3: Colors.blueAccent
        )
        )
      )
    ); // this widget stays here for 2 seconds
  }
}
